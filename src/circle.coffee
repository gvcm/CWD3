class Circle
  build: (element) ->
    @element = element.append('circle')
      .attr('r', @radius)
      .attr('fill', @fill)
      .attr('stroke-width', 0)

  radius: (data) =>
    @constructor.radiusScale(data.weight)

  @radiusScale = d3.scale.sqrt()
    .domain([0, 100])
    .range([5, 5 + (Math.sqrt(100 / Math.PI) * 10)])

  fill: (data) ->
    '#ccc'