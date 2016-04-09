class Group
  constructor: (selected, data) ->
    @data = data
    @nodes = selected.data(data)
    @element = @nodes.enter().append('g')
      .attr('transform', @transform)
      .attr('data-toggle', 'popover')
      .attr('title', @title)
      .attr('data-content', @dataContent)
      .attr('href', @link)
      .attr('data-index', @index)
      .attr('data-placement', @placement)

  transform: (data, index) ->
    "translate(#{data.x},#{data.y})"

  index: (data, index) ->
    index

  placement: (data, index) ->
    if index > 0 then 'right' else 'left'
    
  title: (data, index) ->
    data.title if index > 0

  link: (data) ->
    if data.link? then data.link else '#'

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

  append: (child) ->
    child.build(@element)

  render: ->
    @nodes.exit().remove()

  # cluster: (width, height) ->
  #   tick = (e) =>
  #     return if e.alpha < 0.05
  #     @transform((data, index) ->
  #       if index > 0
  #         "translate(#{data.x},#{data.y})"
  #       else
  #         "translate(#{(width/12.0)*10},#{height/2.0})"
  #     )
  # 
  #   d3.layout.force()
  #     .nodes(@data)
  #     .size([(width/12)*10, height])
  #     .gravity(0.15)
  #     .on('tick', tick)
  #     .start()