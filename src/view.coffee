class View
  constructor: (selector, data) ->
    $container = $(selector)
    $container.height($(window).height() - $container.position().top)
    @width = $container.width()
    @height = $container.height() * 2
    @selection = d3.select(selector)
      .append('svg')
      .attr('width', @width)
      .attr('height', @height)

    group = new Group(@selection.selectAll('g').data(data).enter())
    new Circle(group.selection)
    new Label(group.selection)

    $('[data-toggle="popover"]').popover(
      container: 'body'
      trigger: 'hover'
      html: true
    )

    @render('all')
    View._instance = @

  @getSelection: ->
    View._instance.selection

  render: (tab) ->
    Circle.hide()
    Label.hide()
    d3.selectAll('.volatile').remove()
    halfWidth = @width/2.0
    halfHeight = @height/2.0
    d3.selectAll('g')
      .attr('transform', (data) ->
        theta = 2 * Math.PI * Math.random()
        rx = halfWidth*Math.cos(theta)+halfWidth
        ry = halfHeight*Math.sin(theta)+halfHeight
        "translate(#{rx},#{ry})"
      )
    @[tab + 'Tab']()

  top: ->
    window.scrollTo(0, 0)
    
  center: ->
    window.scrollTo(0, @height / 4)

  scrollLock: (lock) ->
    $('body')
      .css('overflow-x', 'hidden')
      .css('overflow-y', (if lock then 'hidden' else 'scroll'))

  allTab: ->
    group = Group.getInstance()
    total = new Text(@selection)
    @center()
    @scrollLock(true)
    group.all(@width, @height)
      .on('forceEnd', =>
        b = group.boundary()
        total.translate(((b.x1 + b.x2) / 2.0) - 15, b.y2 + 50)
        total.text("TOTAL=#{group.total()}")
        @scrollLock(false)
      )

  categoryTab: ->
    @top()
    @scrollLock(true)

    Circle.show()
    Label.show()

    group = Group.getInstance()    
    group.byCategory(@width, @height)

  scoreTab: ->
    console.log('TODO score')

  criteriaTab: ->
    console.log('TODO criteria')

  popularityTab: ->
    group = new Group(@selection.selectAll('.node').data(@data).enter())
    circle = group.append(new Circle())
    label = group.append(new Label())

    @top()
    @scrollLock(true)

    circle.show()
    label.show()
    
    group.byPopularity(@width, @height)