class Text
  build: (parent) ->
    @element = parent.append('text')
      .attr('dx', 0)
      .attr('dy', 5)
      .attr('text-anchor', 'middle')
      .attr('opacity', 0)
      .text(@text)

  show: ->
    @element.transition().duration(3000).attr('opacity', 1);

  text: (data) ->
    if data.weight > 0
      data.weight
    else
      null