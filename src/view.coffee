class View
  constructor: (selector, data) ->
    $container = $(selector)
    $container.height($(window).height() - $container.position().top)
    @data = data
    @width = $container.width()
    @height = $container.height() * 2
    @selection = d3.select(selector)
      .append('svg')
      .attr('width', @width)
      .attr('height', @height)

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
    d3.selectAll('g').remove()
    d3.selectAll('.volatile').remove()
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
    bubble = new Bubble(@selection.selectAll('g').data(@data).enter())
    bubble.byDefault(@width, @height)
      .on('forceEnd', =>
        boundary = bubble.boundary()
        total.translate(((boundary.x1 + boundary.x2) / 2.0) - 15, boundary.y2 + 50)
        total.text("TOTAL=#{bubble.total()}")
        @scrollLock(false)
      )

  categoryTab: ->
    @top()
    @scrollLock(true)
    bubble = new Bubble(@selection.selectAll('g').data(@data).enter())
    bubble.byCategory(@width, @height)
    bubble.show()

  scoreTab: ->
    console.log('TODO score')

  criteriaTab: ->
    criteriaGroup = {}
    for k,_ of Criteria.hashMap
      criteriaGroup[k] = [] unless criteriaGroup[k]?
      for row in @data
        clonedRow = {}
        for f,v of row
          clonedRow[f] = v
        if k in row.criteriaKeys
          criteriaGroup[k].push(clonedRow)

    counter = 0
    for k,d of criteriaGroup
      if d.length > 0
        counter += 1
        nodeGroup = @selection.append('g')
          .attr('class', 'bubble-' + counter)
          .attr('transform', =>
            rx = Math.random()*@width
            ry = Math.random()*@height
            "translate(#{rx},#{ry})")
        bubble = new Bubble(nodeGroup.selectAll('g.bubble').data(d).enter())
        bubble.byDefault(Math.random() * @width, Math.random() * @height)

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