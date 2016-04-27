class Group
  constructor: (nodes) ->
    @selection = nodes.append('g')
      .attr('data-toggle', 'popover')
      .attr('title', @title)
      .attr('data-content', @dataContent)
      .attr('data-placement', @placement)
      .on('mouseover', @mouseover)
      .on('mouseout', @mouseout)
      .on('click', @click)
    @callbacks = {}
    @force = null
    @

  mouseover: (x) ->
    group = d3.select(this)
    groupNode = group.node()
    groupNode.parentNode.appendChild(groupNode)
    circle = group.selectAll('circle')
    circle
      .attr('data-prev-stroke', circle.attr('stroke'))
      .attr('data-prev-stroke-width', circle.attr('stroke-width'))
      .attr('stroke', 'black')
      .attr('stroke-width', 3)

  mouseout: (x) ->
    group = d3.select(this)
    groupNode = group.node()
    parentNode = groupNode.parentNode
    parentNode.insertBefore(groupNode, parentNode.firstChild)
    circle = group.selectAll('circle')
    circle
      .attr('stroke', circle.attr('data-prev-stroke'))
      .attr('stroke-width', circle.attr('data-prev-stroke-width'))

  placement: (data, index) ->
    if data.group == 'SPEC' then 'left' else 'right'
    
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
        <tr><td style=\"text-align:right\"><strong>Group:</strong></td><td>&nbsp;&nbsp;&nbsp;#{data.group}</td></tr>
        <tr><td colspan=\"2\">#{data.description}</td></tr>
      </table>"
    else if data.title?
      data.title

  transform: (func) ->
    @selection.attr 'transform', func

  append: (child) ->
    child.build(@selection)

  charge: (data, index) ->
    -(data.total + 1) * 20

  all: (width, height) ->
    spec = @selection.filter((data) -> data.group == 'SPEC')
    nodes = @selection.filter((data) -> data.group != 'SPEC')

    tick = (e) =>
      @force.stop() if e.alpha < 0.04
      @transform((data, index) -> "translate(#{data.x},#{data.y})")

    end = (e) =>
      @callbacks['forceEnd']() if @callbacks['forceEnd']?
      spec.transition()
        .duration(500)
        .attr('transform', -> "translate(#{(width/12.0)*10},#{height/2.0})")

    @force = d3.layout.force()
      .nodes(nodes.data())
      .size([(width/12)*10, height])
      .gravity(0.2)
      .charge(@charge)
      .friction(0.8)
      .on('tick', tick)
      .on('end', end)
      .start()
    
    nodes.call(@force.drag)

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
      .domain(Group.categories)
      .range(d3.range(step, step * 10, step))

  byCategory: (width, height) ->
    posy = {}
    columns = Group.columns(width)

    for category in Group.categories
      text = new Text(View.currentInstance.element)
      text.text(group)
      text.translate(columns(group), 200)

    @selection.transition()
    .duration(3000)
    .attr('transform', (data, index) =>
      posy[data.group] = if posy[data.group]? then posy[data.group] + Math.sqrt(data.value * 500) else 1
      "translate(#{columns(data.group)},#{posy[data.group] + 300})"
    )
  
  byPopularity: (width, height) ->
    posy = {}
    columns = Group.columns(width)

    for category in Group.categories
      text = new Text(View.currentInstance.element)
      text.text(group)
      text.translate(columns(group), 200)

    @selection.transition()
    .duration(3000)
    .attr('transform', (data, index) =>
      posy[data.group] = if posy[data.group]? then posy[data.group] + Math.sqrt(data.value * 500) else 1
      "translate(#{columns(data.group)},#{posy[data.group] + 300})"
    )