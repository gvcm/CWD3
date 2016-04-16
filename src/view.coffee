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

  scrollLock: (lock) ->
    body = $('body')
    if lock
      body.css('overflow', 'hidden')
    else
      body.css('overflow-x', 'hidden')
        .css('overflow-y', 'scroll')

  render: (data) ->
    group = new Group(@element.selectAll('.node'), data)
    circle = new Circle()
    label = new Label()
    total = new Text(@element)
    group.append(circle)
    group.append(label)

    window.scrollTo(0, @height / 4)
    @scrollLock(true)

    circle.show()
    label.show()

    group.cluster(@width, @height)
      .on('forceEnd', =>
        b = group.boundary()
        total.translate(((b.x1 + b.x2) / 2.0) - 15, b.y2 + 50)
        total.text("TOTAL=#{group.total()}")
        @scrollLock(false)
      )