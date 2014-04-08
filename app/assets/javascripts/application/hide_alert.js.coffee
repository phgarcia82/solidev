@hide = (divname) ->
  $('#'+divname).delay(3000).animate
    opacity: '0'
    1000
    () ->
      $('#'+divname).hide()