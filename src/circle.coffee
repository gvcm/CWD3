class Circle
  build: (parent) ->
    @element = parent.append('circle')
      .attr('r', @radius)
      .attr('fill', @fill)
      .attr('stroke-width', 0)

  # radius: (data) =>
  #   Circle.radiusScale(data.weight)

  radius: (data) =>
    Circle.radiusScale(data.r)

  fill: (data) ->
    Circle.backgroundPallete(data.group)

  # show: ->
  #   @element.transition().duration(3000).attr('r', @radius);

  @backgroundPallete = d3.scale.ordinal()
    .domain(['CW', 'T', 'L', 'F2', 'F1', 'Z', 'C', 'D'])
    .range(['#d3372c', '#2767b3', '#85898f', '#e89e78', '#3f9657', '#b3c841','#efb052', '#5d3b5a'])

  @radiusScale = d3.scale.sqrt()
    .domain([0, 100])
    .range([5, 5 + (Math.sqrt(100 / Math.PI) * 10)])