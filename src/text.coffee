class Text
  build: (parent) ->
    @element = parent.append('text')
      .attr('font-weight', 'bold')
      .text('')
    @

  # constructor: (parent) ->
  #   @element = parent.append('text')
  #     .attr('font-weight', 'bold')
  #     .text('')
      
  translate: (x, y) ->
    @element.attr 'transform', "translate(#{x},#{y})"

  hide: ->
    @element.attr('opacity', 0)

  show: ->
    @element.transition().duration(1000).attr('opacity', 1)

  text: (text) ->
    @hide()
    @element.text(text)
    @show()