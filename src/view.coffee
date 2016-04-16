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
    label = new Label()
    group.append(circle)
    group.append(label)
    circle.show()
    total = new Text(@element)
    group.cluster(@width, @height)
      .on('forceEnd', =>
        b = group.boundary()
        label.show()
        total.translate(((b.x1 + b.x2) / 2.0) - 15, b.y2 + 50)
        total.text("TOTAL=#{group.total()}")
      )