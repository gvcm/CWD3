class Group
  constructor: (selected, data) ->
    @nodes = selected.data(data)
    @element = @nodes.enter().append('g')
      .attr('data-toggle', 'popover')
      .attr('title', @title)
      .attr('data-content', @dataContent)
      .attr('transform', @transform)
      .attr('href', @link)

  title: (data) ->
    data.title

  link: (data) ->
    data.link

  dataContent: (data) ->
    '<table>' +
    '<tr><td style="text-align:right"><strong>Total:</strong></td><td>&nbsp;&nbsp;&nbsp;' + data.total + '</td></tr>' +
    '<tr><td style="text-align:right"><strong>Scores 1–5:</strong></td><td>&nbsp;&nbsp;&nbsp;' + data.score.join(', ') + '</td></tr>' +
    '<tr><td style="text-align:right"><strong>Group:</strong></td><td>&nbsp;&nbsp;&nbsp;' + data.group + '</td></tr>' +
    '<tr><td colspan="2">' + data.description + '</td></tr>' +
    '</table>'

  transform: (data) ->
    x = Math.random() * 1000
    y = Math.random() * 1000
    'translate(' + x + ',' + y + ')'

  append: (child) ->
    child.build(@element)

  render: ->
    @nodes.exit().remove()