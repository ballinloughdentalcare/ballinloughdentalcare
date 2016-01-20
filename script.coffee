@document.addEventListener 'DOMContentLoaded', (event) ->
  for gallery in @querySelectorAll('div.gallery')
    new Flickity gallery,
      wrapAround: true
      autoPlay: true
