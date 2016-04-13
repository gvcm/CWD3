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

    pack = d3.layout.pack()
      .size([@width * 0.8, @height * 0.8])
    
    group = new Group(@element.selectAll('.node'), pack.nodes(data))
    circle = new Circle()
    text = new Text()
    group.append(circle)
    group.append(text)
    group.render()
    circle.show()
    text.show()