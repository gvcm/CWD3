class View
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

  render: (tab) ->
    @element.selectAll('*').remove()
    @tabs()[tab]()

  center: ->
    window.scrollTo(0, @height / 4)

  scrollLock: (lock) ->
    $('body').css('overflow', (if lock then 'hidden' else 'scroll'))

  tabs: ->
    all: =>
      group = new Group(@element.selectAll('.node').data(@data).enter())
      circle = group.append(new Circle())
      label = group.append(new Label())
      total = new Text(@element)

      @center()
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

    group: =>
      console.log('TODO group')

    score: =>
      console.log('TODO score')

    criteria: =>
      console.log('TODO criteria')

    popularity: =>
      console.log('TODO popularity')