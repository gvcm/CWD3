class Text
  build: (element) ->
    @element = element.append('text')
      .attr('dx', 0)
      .attr('dy', 5)
      .attr('text-anchor', 'middle')
      .text(@text)

  text: (data) ->
    data.weight