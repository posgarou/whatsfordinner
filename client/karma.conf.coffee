module.exports = (config) ->
  config.set
    files: [
      'public/js/vendor.min.js',
      'public/js/all.min.js',
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
      'karma-jasmine',
      'karma-jasmine-jquery',
      'karma-jasmine-matchers'
    ]

    preprocessors: {
      'test/**/*.coffee': ['coffee'],
      '**/*.html': ['html2js']
    }

#    coffeePreprocessor: {
#      # options passed to the coffee compiler
#      options: {
#        bare: true,
#        sourceMap: false
#      },
#      # transforming the filenames
#      transformPath: (path) ->
#        return path.replace('.js', '.coffee')
#    }