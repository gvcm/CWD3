class Bubble
  constructor: (nodes, bubbleClass) ->
    bubbleClass = 'bubble' unless bubbleClass?
    @selection = nodes.append('g')
      .attr('class', bubbleClass)
      .attr('data-toggle', 'popover')
      .attr('title', @title)
      .attr('data-content', @dataContent)
      .attr('data-placement', @placement)
      .attr('opacity', @opacity)
      .on('mouseover', @mouseover)
      .on('mouseout', @mouseout)
      .on('click', @click)
    @callbacks = {}
    @force = null
    @circle = new Circle(@selection)
    @label = new Label(@selection)

    @selection.attr('transform', (data) ->
      theta = 2 * Math.PI * Math.random()
      rx = 500*Math.cos(theta)+500
      ry = 500*Math.sin(theta)+500
      "translate(#{rx},#{ry})"
    )

  show: ->
    @circle.show()
    @label.show()

  hide: ->
    @circle.hide()
    @label.hide()

  opacity: (data) =>
    return 1 if View.showRef()
    if (data.group == 'SPEC' or data.group == 'CW') then 0 else 1

  mouseover: (x) ->
    bubble = d3.select(this)
    bubbleNode = bubble.node()
    bubbleNode.parentNode.appendChild(bubbleNode)
    circle = bubble.selectAll('circle')
    circle
      .attr('data-prev-stroke', circle.attr('stroke'))
      .attr('data-prev-stroke-width', circle.attr('stroke-width'))
      .attr('stroke', 'black')
      .attr('stroke-width', 3)

  mouseout: (x) ->
    bubble = d3.select(this)
    bubbleNode = bubble.node()
    parentNode = bubbleNode.parentNode
    parentNode.insertBefore(bubbleNode, parentNode.firstChild)
    circle = bubble.selectAll('circle')
    circle
      .attr('stroke', circle.attr('data-prev-stroke'))
      .attr('stroke-width', circle.attr('data-prev-stroke-width'))

  placement: (data, index) ->
    # if data.group == 'SPEC' then 'left' else 'right'
    'bottom'
    
  title: (data, index) ->
    data.title unless data.group == 'SPEC'

  click: (data) ->
    return if d3.event.defaultPrevented
    if data.link? and data.link != ''
      window.open(data.link, '_blank')

  dataContent: (data, index) ->
    if data.total? and data.score? and data.group? and data.description?
      "
      <table>
        <tr><td style=\"text-align:right\"><strong>Total:</strong></td><td>&nbsp;&nbsp;&nbsp;#{data.total}</td></tr>
        <tr><td style=\"text-align:right\"><strong>Scores 1–5:</strong></td><td>&nbsp;&nbsp;&nbsp;#{data.score.join(', ')}</td></tr>
        <tr><td style=\"text-align:right\"><strong>Bubble:</strong></td><td>&nbsp;&nbsp;&nbsp;#{data.group}</td></tr>
        <tr><td colspan=\"2\">#{data.description}</td></tr>
      </table>"
    else if data.title?
      data.title

  transform: (func) ->
    @selection.attr 'transform', func

  charge: (data, index) ->
    -(data.total + 1) * 25

  byDefault: (width, height) ->
    showRef = View.showRef()
    
    if showRef
      spec = @selection.filter((data) -> data.group == 'SPEC')
      spec.transition()
        .duration(500)
        .attr('transform', -> "translate(#{(width/12.0)*10},#{height/2.0})")

    nodes = @selection.filter((data) ->
      if showRef
        data.group != 'SPEC'
      else
        data.group != 'SPEC' and data.group != 'CW'
    )

    tick = (e) =>
      if e.alpha < 0.04
        @force.stop()
        nodes.transition()
          .duration(2000)
          .attr('transform', (data) -> "translate(#{data.x},#{data.y})")
        @show()

    end = (e) =>
      @callbacks['forceEnd']() if @callbacks['forceEnd']?

    @force = d3.layout.force()
      .nodes(nodes.data())
      .size([(width/12)*10, height])
      .gravity(0.2)
      .charge(@charge)
      .friction(0.8)
      .on('tick', tick)
      .on('end', end)
      .start()
    @

  boundary: ->
    data = @selection.filter((data) -> data.group != 'SPEC').data()
    x = data.map((row) -> row.x)
    y = data.map((row) -> row.y)
    { x1: d3.min(x), x2: d3.max(x), y1: d3.min(y), y2: d3.max(y) }

  total: ->
    @selection.data().length - 1

  on: (event, callback) ->
    @callbacks[event] = callback
    @

  @categories: ['SPEC', 'CW', 'T', 'L', 'F2', 'F1', 'Z', 'C', 'D']

  @columns: (width) ->    
    step = width / 10.0
    d3.scale.ordinal()
      .domain(Bubble.categories)
      .range(d3.range(step, step * 10, step))

  byCategory: (width, height) ->
    posy = {}
    columns = Bubble.columns(width)
    svg = d3.select('svg')

    for category in Bubble.categories
      text = new Text(svg)
      text.text(category)
      text.translate(columns(category), 200)

    @selection.transition()
    .duration(3000)
    .attr('transform', (data, index) =>
      posy[data.group] = if posy[data.group]? then posy[data.group] + Math.sqrt(data.value * 500) else 1
      "translate(#{columns(data.group)},#{posy[data.group] + 300})"
    )
  
  byPopularity: (width, height) ->
    posy = {}
    columns = Bubble.columns(width)

    for category in Bubble.categories
      text = new Text(View.currentInstance.element)

    @selection.transition()
    .duration(3000)
    .attr('transform', (data, index) =>
      posy[data.group] = if posy[data.group]? then posy[data.group] + Math.sqrt(data.value * 500) else 1
      "translate(#{columns(data.group)},#{posy[data.group] + 300})"
    )