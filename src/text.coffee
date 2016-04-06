class Text
  build: (parent) ->
    @element = parent.append('text')
      .attr('dx', 0)
      .attr('dy', 5)
      .attr('text-anchor', 'middle')
      .text(@text)

  text: (data) ->
    if data.weight > 0
      data.weight
    else
      null