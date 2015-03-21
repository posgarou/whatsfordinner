# Source https://gist.github.com/maruf-nc/5625869#comment-1220781
angular
.module('whatsForDinnerApp')
.filter('TitleCase', ->
  (str) ->
    if str?
      str.replace(/_|-/, ' ').replace(/\w\S*/g, (txt) ->
        txt[0].toUpperCase() + txt[1..txt.length - 1].toLowerCase()
      )
    else
      ''
)
