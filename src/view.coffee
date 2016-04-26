class View
  @currentInstance: null
  
  constructor: (selector, data) ->
    $container = $(selector)
    $container.height($(window).height() - $container.position().top)
    @width = $container.width()
    @height = $container.height() * 2
    @element = d3.select(selector)
      .append('svg')
      .attr('width', @width)
      .attr('height', @height)
    @data = data
    @render('all')
    View.currentInstance = @

  render: (tab) ->
    for row in @data
      # row.x = (@width/12.0)*10
      # row.y = (@height/2.0
      row.x = Math.random() * @width
      row.y = Math.random() * @height

    @element.selectAll('*').remove()
    @[tab + 'Tab']()
    $('[data-toggle="popover"]').popover(
      container: 'body'
      trigger: 'hover'
      html: true
    )

  top: ->
    window.scrollTo(0, 0)
    
  center: ->
    window.scrollTo(0, @height / 4)

  scrollLock: (lock) ->
    $('body').css('overflow', (if lock then 'hidden' else 'scroll'))

  allTab: ->
    group = new Group(@element.selectAll('.node').data(@data).enter())
    circle = group.append(new Circle())
    label = group.append(new Label())
    total = new Text(@element)

    @center()
    @scrollLock(true)

    circle.show()
    label.show()

    group.clusterize(@width, @height)
      .on('forceEnd', =>
        b = group.boundary()
        total.translate(((b.x1 + b.x2) / 2.0) - 15, b.y2 + 50)
        total.text("TOTAL=#{group.total()}")
        @scrollLock(false)
      )

  categoryTab: ->
    group = new Group(@element.selectAll('.node').data(@data).enter())
    circle = group.append(new Circle())
    label = group.append(new Label())

    @top()
    @scrollLock(true)

    circle.show()
    label.show()
    
    group.columnize(@width, @height)

  scoreTab: ->
    console.log('TODO score')

  criteriaTab: ->
    console.log('TODO criteria')

  popularityTab: ->
    console.log('TODO popularity')