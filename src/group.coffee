class Group
  build: (parent) ->
    @element = parent.append('g')
      .attr('data-toggle', 'popover')
      .attr('title', @title)
      .attr('data-content', @dataContent)
      .attr('data-placement', @placement)
      .on('mouseover', @mouseover)
      .on('mouseout', @mouseout)
      .on('click', @click)
    @callbacks = {}
    @force = null
  
  constructor: (selected, data) ->
    @nodes = selected.data(data)
    @element = @nodes.enter().append('g')
      .attr('data-toggle', 'popover')
      .attr('title', @title)
      .attr('data-content', @dataContent)
      .attr('data-placement', @placement)
      .on('mouseover', @mouseover)
      .on('mouseout', @mouseout)
      .on('click', @click)
    @callbacks = {}
    @force = null

  mouseover: (x) ->
    group = d3.select(this)
    groupElement = group[0][0]
    groupElement.parentNode.appendChild(groupElement)
    circle = group.selectAll('circle')
    circle
      .attr('data-prev-stroke', circle.attr('stroke'))
      .attr('data-prev-stroke-width', circle.attr('stroke-width'))
      .attr('stroke', 'black')
      .attr('stroke-width', 3)

  mouseout: (x) ->
    group = d3.select(this)
    groupElement = group[0][0]
    parentNode = groupElement.parentNode
    parentNode.insertBefore(groupElement, parentNode.firstChild)
    circle = group.selectAll('circle')
    circle
      .attr('stroke', circle.attr('data-prev-stroke'))
      .attr('stroke-width', circle.attr('data-prev-stroke-width'))

  placement: (data, index) ->
    if index > 0 then 'right' else 'left'
    
  title: (data, index) ->
    data.title if index > 0

  click: (data) ->
    return if d3.event.defaultPrevented
    if data.link? and data.link != ''
      window.open(data.link, '_blank')

  dataContent: (data, index) ->
    if index > 0
      "
      <table>
        <tr><td style=\"text-align:right\"><strong>Total:</strong></td><td>&nbsp;&nbsp;&nbsp;#{data.total}</td></tr>
        <tr><td style=\"text-align:right\"><strong>Scores 1–5:</strong></td><td>&nbsp;&nbsp;&nbsp;#{data.score.join(', ')}</td></tr>
        <tr><td style=\"text-align:right\"><strong>Group:</strong></td><td>&nbsp;&nbsp;&nbsp;#{data.group}</td></tr>
        <tr><td colspan=\"2\">#{data.description}</td></tr>
      </table>"
    else
      data.title

  transform: (func) ->
    func ?= (data) ->
      if data.x and data.y
        "translate(#{data.x},#{data.y})"
    @element.attr 'transform', func

  append: (child) ->
    child.build(@element)

  charge: (data, index) ->
    return 0 if index == 0
    return -(data.total + 1) * 25

  cluster: (width, height) ->

    tick = (e) =>
      @force.stop() if e.alpha < 0.05
      @transform((data, index) ->
        return "translate(#{(width/12.0)*10},#{height/2.0})" if index == 0
        "translate(#{data.x},#{data.y})"
      )

    end = (e) =>
      @callbacks['forceEnd']() if @callbacks['forceEnd']?

    @element.data()[0].fixed = true
    
    @force = d3.layout.force()
      .nodes(@element.data())
      .size([(width/12)*10, height])
      .gravity(0.2)
      .charge(@charge)
      .on('tick', tick)
      .on('end', end)
      .start()

    @element.call(@force.drag)
    @

  boundary: ->
    data = @element.data().slice(1)
    x = data.map((row) -> row.x)
    y = data.map((row) -> row.y)
    { x1: d3.min(x), x2: d3.max(x), y1: d3.min(y), y2: d3.max(y) }

  total: ->
    @element.data().length

  on: (event, callback) ->
    @callbacks[event] = callback
    @