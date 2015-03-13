//
// RUNNING
//
// To compile for development, just run `$ gulp`.
//
// To compile for production, either
//   1. set NODE_ENV='production' and call `$ gulp`
//   2. call `$ gulp --env=production`
//   3. or just initialize the Sinatra app when RACK_ENV=production
//
// Note that the default task automatically downloads all bower_components.
// (It does not run `$ npm install`, however.)

///////////////////////////
// SETUP THE ENVIRONMENT //
///////////////////////////

var minimist = require('minimist');

var knownOptions = {
    string: 'env',
    default: { env: process.env.NODE_ENV || 'development' }
};

// Use the --env flag, if set; otherwise, default to the default given above.
var options = minimist(process.argv.slice(2), knownOptions);

///////////////////////////
//      DEPENDENCIES     //
///////////////////////////

var gulp = require('gulp'),
    bower = require('gulp-bower'), // convenient interface into bower
    coffee = require('gulp-coffee'),// compile .coffee
    concat = require('gulp-concat'), // combine files into one
    gulpIf = require('gulp-if'), // ease conditional running of pipes
    imagemin = require('gulp-imagemin'), // compress files
    jade = require('gulp-jade'),// compile .jade templates
    minifyHTML = require('gulp-minify-html'), //shrink down HTML files
    html2js = require('gulp-ng-html2js'),// compiling html templates into templates.js
    revAll = require('gulp-rev-all'), // (1) add hash cache breaker and (2) fix references to un-cache-broken files
    sass = require('gulp-sass'), // compile sass
    uglify = require('gulp-uglify'),// minify .js
    gulpUtil = require('gulp-util'),// a couple convenient util funcs (just use .noop here)
    del = require('del'), // delete system files
    _ = require('lodash'), // underscore replacement
    mainBowerFiles = require('main-bower-files'),// grab the file(s) listed as main in each bower's package.json
    vinylPaths = require('vinyl-paths'); // file path interface/manager


///////////////////////////
//   UTILITY FUNCTIONS   //
///////////////////////////

// If +val+ is a function, call it; otherwise, return +val+.
var callOrReturn = function(val) {
    return (typeof(val) == 'function') ? val() : val;
};


///////////////////////////
// CONFIGURATION CLASSES //
///////////////////////////

// Represents an environment-specific configuration hash.
// This hash is expected to have at least a :default key.
function Configuration(configurationHash) {
    this.configurationHash = configurationHash;
}

// Find the settings for the current environment and return its setting for +key+.
// If the current environment does not exist in the hash or does not have +key+ defined, return the
// :default value for +key+.
Configuration.prototype.get = function(key) {
    var current_set = this.configurationHash[options.env];
    return (current_set && callOrReturn(current_set[key])) || callOrReturn(this.configurationHash['default'][key]);
};

Configuration.prototype.mergedOptionsForCurrentEnv = function() {
    return _.extend(_.clone(this.configurationHash['default']), (this.configurationHash[options.env] || {}) );
};

// Similar to Configuration above.  Main difference is that ConfigurationSet assumes the +configurationHash+
// is a dictionary of arrays rather than a dictionary of objects.
function ConfigurationSet(configurationHash) {
    this.configurationHash = configurationHash;
}

// If there is a non-empty configuration set for the current environment, return that; otherwise, return 'default'
ConfigurationSet.prototype.forCurrentEnv = function() {
    var env_set = this.configurationHash[options.env] || [];
    var toReturn = env_set.length > 0 ? env_set : this.configurationHash['default'];
    return Array.isArray(toReturn) ?  _.map(toReturn, callOrReturn) : callOrReturn(toReturn);
};


///////////////////////////
// CONFIGURATION OPTIONS //
///////////////////////////

// The output file names for certain key files
var outputFiles = new Configuration(require('./config/outputFileNames.json'));

// Specify asset paths
var paths = new Configuration(require('./config/assetSources.json'));

// The directory in which to place assets for each
var distDir = new ConfigurationSet({
    default: './public'
});

// Compiled/processed asset output paths
var outputPaths = new Configuration({
    default: {
        scripts: function() { return distDir.forCurrentEnv() + '/js'; },
        styles: function() { return distDir.forCurrentEnv() + '/css'; },
        images: function() { return distDir.forCurrentEnv() + '/images'; },
        views: function() { return distDir.forCurrentEnv() + '/views'; }
    }
});

// A series of environment-specific configuration options
var config = new Configuration(require('./config/environmentalConfig.json'));

// We need to specify the order in which the various libraries should be included
var libraries = new ConfigurationSet({
    default: [
        function() { return paths.get('lib') + '/jquery.js'; },
        function() { return paths.get('bower') + '/underscore/underscore.js'; },
        function() { return paths.get('lib') + '/angular.js'; },
        function() { return paths.get('lib') + '/**/*.js'; },
        function() { return paths.get('lib') + '/*.js'; }
    ]
});


///////////////////////////
//     GRANULAR TASKS    //
///////////////////////////

// Compile, minify, and concatenate all of the coffeescript files. Place in public/js/all.min.js
// Only uglify if config.shouldUglify is true
gulp.task('scripts', function() {
    // Delete the current scripts, both straight compiled and cache-keyed
    del.sync(outputPaths.get('scripts') + '/**/*.js');

    // Compile Coffescript, minify and uglify JS
    return gulp.src(paths.get('scripts'))
        .pipe(coffee())
        .pipe(gulpIf(config.get('shouldUglify'), uglify()))
        .pipe(concat(outputFiles.get('allJS')))
        .pipe(gulp.dest(outputPaths.get('scripts')));
});

// Run imagemin on all images and pipe them to public/images
gulp.task('images', function() {
    // Delete the current images, both straight compiled and cache-keyed
    del.sync(outputPaths.get('images') + '/**/*.*');

    return gulp.src(paths.get('images'))
        .pipe(gulpIf(config.get('shouldOptimizeImages'), imagemin({optimizationLevel: 5})))
        .pipe(gulp.dest(outputPaths.get('images')));
});

// Compile all of the sass in assets/css, concatenate it, and pipe it to public/css/main.css
gulp.task('styles', function() {
    // Delete the current styles, both straight compiled and cache-keyed
    del.sync(outputPaths.get('styles') + '/**/*.css');

    return gulp.src(paths.get('styles'))
        .pipe(sass())
        .pipe(concat(outputFiles.get('mainCSS')))
        .pipe(gulp.dest(outputPaths.get('styles')));
});

// Compile all Jade templates and pipe them to public/views
gulp.task('compile-jade', function() {
    // Delete the current views, both straight compiled and cache-keyed
    del.sync(outputPaths.get('views') + '/**/*.html');

    var LOCALS = outputFiles.mergedOptionsForCurrentEnv();
    return gulp.src(paths.get('views'))
        .pipe(jade({
            locals: LOCALS
        }))
        .pipe(gulp.dest(outputPaths.get('views')));
});

// Convert all of the templates into a simple template.js file.
gulp.task('compile-templates', ['compile-jade', 'scripts'], function() {
    return gulp.src(outputPaths.get('views') + '/components/**/*.html')
        .pipe(minifyHTML({
            empty: true,
            spare: true,
            quotes: true
        }))
        .pipe(html2js({
            moduleName: 'templates',
            prefix: 'views/components/'
        }))
        .pipe(concat(outputFiles.get('templateJS')))
        .pipe(uglify())
        .pipe(gulp.dest(outputPaths.get('scripts')));
});

// Run bower install
gulp.task('bower-install', function() {
    return bower().pipe(gulp.dest(paths.get('bower')));
});

// Copy all of the "main" bower files into public/lib
gulp.task("bower-files", ['bower-install'], function() {
    return gulp.src(mainBowerFiles()).pipe(gulp.dest(paths.get('lib')));
});

// Uglify and concat everything in lib and save it to public/js as vendor.min.js
gulp.task('vendor-concat', ['bower-files'], function() {
    // Delete the old version of vendorJS (if it exists)
    del.sync(outputPaths.get('scripts') + '/' + outputFiles.get('vendorJS'));

    return gulp.src(libraries.forCurrentEnv())
        .pipe(gulpIf(config.get('shouldUglify'), uglify()))
        .pipe(concat(outputFiles.get('vendorJS')))
        .pipe(gulp.dest(outputPaths.get('scripts')));
});

// Conditionally setup cache busting
gulp.task('handle-assets', ['compile-assets'], function() {
    currentFiles = vinylPaths();

    // Delete the old manifest (if it exists)
    del('./tmp/manifest.json');

    if (config.get('shouldCacheBust')) {
        // Do not cache bust the component template files: the templates.js is itself cache-busted
        console.log('!' + outputPaths.get('views') + '/components/**/*.html');
        return gulp.src([distDir.forCurrentEnv() + '/**/*.*', '!' + outputPaths.get('views') + '/components/**/*.html'])
            .pipe(currentFiles) // save the current file list
            .pipe(revAll( { ignore:
                [
                    outputPaths.get('scripts') + '/' + outputFiles.get('templateJS'),
                    new RegExp('/components/(.+)\.html')
                ]
            } )) // create a cache-busted version
            .pipe(gulp.dest(distDir.forCurrentEnv())) // save rev'd files in distDir
            .pipe(revAll.manifest({ fileName: 'manifest.json' })) // create a rev manifest
            .pipe(gulp.dest('./tmp')) // save the rev manifest
            .on('end', function() {
                del(currentFiles.paths); // when done, delete all the files originally there
            });
    } else {
        return gulpUtil.noop();
    }
});


///////////////////////////
//    COMPOSITE TASKS    //
///////////////////////////

// Run bower-install and bower-files
gulp.task('bower', ['vendor-concat']);

gulp.task('compile-assets', ['bower', 'compile-templates', 'scripts', 'styles', 'images']);

// The default set of tasks should run bower, compile-jade, scripts, styles, and images
// It should also cache bust and modify paths accordingly (if appropriate for the environment).
gulp.task('default', ['handle-assets']);