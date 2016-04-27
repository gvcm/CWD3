class Text
  constructor: (parent) ->
    @selection = parent.append('text')
      .classed('volatile', true)
      .attr('font-weight', 'bold')
      .text('')
    @

  translate: (x, y) ->
    @selection.attr 'transform', "translate(#{x},#{y})"

  hide: ->
    @selection.attr('opacity', 0)

  show: ->
    @selection.transition().duration(1000).attr('opacity', 1)

  text: (text) ->
    @hide()
    @selection.text(text)
    @show()