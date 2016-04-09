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
      .size([@width, @height])
    
    # node = @element.selectAll('.node')
    #   .data(pack.nodes(data))
    #   .enter().append('g')
    #   .attr('transform', (d) -> "translate(#{d.x},#{d.y})")
    #   
    # node.append('circle')
    #   .attr('r', (d) -> d.r)
    #   .attr('stroke', 'red')
    #   .attr('stroke-width', 2)

    group = new Group(@element.selectAll('.node'), pack.nodes(data))
    circle = new Circle()
    text = new Text()
    group.append(circle)
    # group.append(text)
    group.render()
    # circle.show()
    # text.show()
    # group.cluster(@width, @height)