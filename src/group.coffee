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
      .attr('data-placement', 'bottom')

  transform: (data, index) ->
    "translate(#{data.x},#{data.y})"

  title: (data) ->
    data.title if data.title?

  link: (data) ->
    if data.link? then data.link else '#'

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

  append: (child) ->
    child.build(@element)

  render: ->
    @nodes.exit().remove()