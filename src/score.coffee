class Score
  constructor: (nodes) ->
    @selection = nodes.append('g')
    @circle = new Circle(@selection)
    @circle.show()


  byDefault: (width, height) ->
    columnSize = width / 10
    @selection.attr('transform', (data) ->
      rx = data.x * columnSize + 500
      ry = data.y * 100 + 250
      "translate(#{rx},#{ry})"
    )