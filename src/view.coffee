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

    @bubble = new Bubble(@selection.selectAll('g').data(data).enter())

    $('[data-toggle="popover"]').popover(
      container: 'body'
      trigger: 'hover'
      html: true
    )

    @render()
    View._instance = @

  @getSelection: ->
    View._instance.selection

  render: (tab) ->
    tab = 'default' unless tab?
    @@bubble.hide()
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

  defaultTab: ->
    total = new Text(@selection)
    @center()
    @scrollLock(true)
    @bubble.byDefault(@width, @height)
      .on('forceEnd', =>
        b = @bubble.boundary()
        total.translate(((b.x1 + b.x2) / 2.0) - 15, b.y2 + 50)
        total.text("TOTAL=#{@bubble.total()}")
        @scrollLock(false)
      )

  categoryTab: ->
    @top()
    @scrollLock(true)
    @bubble.byCategory(@width, @height)
    @bubble.show()

  scoreTab: ->
    console.log('TODO score')

  criteriaTab: ->
    console.log('TODO criteria')

  popularityTab: ->
    # group = new Bubble(@selection.selectAll('.node').data(@data).enter())
    # circle = group.append(new Circle())
    # label = group.append(new Label())
    # 
    # @top()
    # @scrollLock(true)
    # 
    # circle.show()
    # label.show()
    # 
    # group.byPopularity(@width, @height)