module.exports = (config) ->
  config.set
    basePath: '.',
    files: [
      'public/js/vendor.min.js',
      'public/js/all.min.js',
      {
        pattern: 'public/views/**/*.html',
        included: true
      },
      {
        pattern: 'test/unit/**/*.coffee',
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
      'karma-ng-html2js-preprocessor',
      'karma-jasmine',
      'karma-jasmine-jquery',
      'karma-jasmine-matchers'
    ]

    preprocessors: {
      'test/**/*.coffee': ['coffee'],
      'public/**/*.html': ['ng-html2js']
    }


    ngHtml2JsPreprocessor: {
      stripPrefix: 'public/',
      moduleName: 'whatsForDinnerApp'
    }