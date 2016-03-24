class View
  constructor: (selector) ->
    @container = $(selector)
    @element = d3.select(selector)
      .append('svg')
      .attr('width', @container.width())
      .attr('height', 500)

  render: (data) ->
    group = new Group(@element.selectAll('.node'), data)
    group.append(new Circle())
    group.append(new Text())
    group.render()