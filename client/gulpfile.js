// RUNNING
// All tasks are called (in proper order) inside default

var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    concat = require('gulp-concat'),
    uglify = require('gulp-uglify'),
    clean = require('gulp-clean'),
    sass = require('gulp-sass'),
    imagemin = require('gulp-imagemin'),
    notify = require('gulp-notify'),
    bower = require('gulp-bower'),
    mainBowerFiles = require('main-bower-files'),
    jade = require('gulp-jade'),
    watch = require('gulp-watch');

// Specify asset paths
var paths = {
    scripts: ['app/app.coffee', 'app/**/*.coffee', 'app/**/*.js'],
    styles:  ['assets/css/style.scss', 'assets/css/**/*.css'],
    images: ['assets/images/**/*'],
    views: ['views/**/*.jade'],
    lib: 'lib/'
};

// Specify the bower directory
var config = {
    bowerDir: './bower_components',
    viewDestDir: './public/views'
};

// We need to specify the order in which the various libraries should be included
var libraries = [
    paths.lib + 'jquery.js',
    'bower_components/underscore/underscore.js',
    paths.lib + 'angular.js',
    paths.lib + '**/*.js'
];

// Compile, minify, and concatenate all of the coffeescript files. Place in public/js/all.min.js
gulp.task('scripts', function() {
    // Compile Coffescript, minify and uglify JS
    return gulp.src(paths.scripts)
        .pipe(coffee())
        .pipe(uglify())
        .pipe(concat('all.min.js'))
        .pipe(gulp.dest('public/js'));
});

// Run imagemin on all images and pipe them to public/images
gulp.task('images', function() {
    return gulp.src(paths.images)
        .pipe(imagemin({optimizationLevel: 5}))
        .pipe(gulp.dest('public/images'));
});

// Compile all of the sass in assets/css, concatenate it, and pipe it to public/css/main.css
gulp.task('styles', function() {
    return gulp.src(paths.styles)
        .pipe(sass())
        .pipe(concat('main.css'))
        .pipe(gulp.dest('public/css'));
});

// Compile all Jade templates and pipe them to public/views
gulp.task('compile-jade', function() {
    var LOCALS = {};
    gulp.src(paths.views)
        .pipe(jade({
            locals: LOCALS
        }))
        .pipe(gulp.dest(config.viewDestDir));
});

// Run bower install
gulp.task('bower-install', function() {
    return bower().pipe(gulp.dest(config.bowerDir));
});

// Copy all of the "main" bower files into public/lib
gulp.task("bower-files", function() {
    return gulp.src(mainBowerFiles()).pipe(gulp.dest(paths.lib));
});

gulp.task('vendor-concat', function() {
    return gulp.src(libraries)
        .pipe(uglify())
        .pipe(concat('vendor.min.js'))
        .pipe(gulp.dest('public/js/'));
});

// Run bower-install and bower-files
gulp.task('bower', ['bower-install', 'bower-files', 'vendor-concat']);

gulp.task('watch', function() {
    gulp.watch(paths.views, ['compile-jade']);
    gulp.watch(paths.scripts, ['scripts']);
    gulp.watch(paths.styles, ['styles']);
    gulp.watch(paths.images, ['images']);
    gulp.watch('bower.json', ['bower']);
});

// Run bower, compile-jade, scripts, styles, and images
gulp.task('default', ['bower', 'compile-jade', 'scripts', 'styles', 'images']);