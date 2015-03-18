# TODO Add in the Jade precompiler again

module.exports = (config) ->
  config.set
    basePath: '.',
    files: [
      'public/js/vendor.js',
      'public/js/templates.min.js',

      {
        pattern: 'app/app.coffee',
        included: true
      },
      {
        pattern: 'app/app.routes.coffee',
        included: true
      },
      {
        pattern: 'app/**/*.coffee',
        included: true
      }
    ]

    autoWatch: true
    singleRun: false

    colors: true

    frameworks: ['jasmine']

    browsers: ['Chrome']

    plugins: [
      'karma-coffee-preprocessor',
      'karma-chrome-launcher',
      'karma-jade-preprocessor',
      'karma-ng-html2js-preprocessor',
      'karma-jasmine',
      'karma-jasmine-jquery',
      'karma-jasmine-matchers'
    ]

    preprocessors: {
      'app/**/*.coffee': ['coffee'],
      'test/**/*.coffee': ['coffee'],
      '*.jade': ['jade', 'ng-html2js']
    }


    ngHtml2JsPreprocessor: {
      stripPrefix: 'public/',
      moduleName: 'whatsForDinnerApp'
    }
