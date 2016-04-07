class View
  constructor: (selector) ->
    @container = $(selector)
    @container.height($(window).height() - @container.position().top)
    @width = @container.width()
    @height = @container.height() * 2
    @element = d3.select(selector)
      .append('svg')
      .attr('width', @width)
      .attr('height', @height)

  render: (data) ->
    group = new Group(@element.selectAll('.node'), data)
    circle = new Circle()
    text = new Text()
    group.append(circle)
    group.append(text)
    group.render()
    circle.show()
    text.show()
    group.cluster(@width, @height)