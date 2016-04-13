class Circle
  build: (parent) ->
    @element = parent.append('circle')
      .filter((data) -> 
        !data.children
      )
      .attr('r', 0)
      .attr('fill', @fill)
      .attr('stroke-width', 1)
      .attr('stroke', 'black')

  radius: (data) =>
    Circle.radiusScale(data.r)
  
  fill: (data) ->
    Circle.backgroundPallete(data.group)

  show: ->
    @element.transition().duration(3000).attr('r', @radius);

  # @backgroundPallete = d3.scale.category10()
  @backgroundPallete = d3.scale.ordinal()
    .domain(['CW', 'T', 'L', 'F2', 'F1', 'Z', 'C', 'D'])
    .range(['#d3372c', '#2767b3', '#85898f', '#e89e78', '#3f9657', '#b3c841','#efb052', '#5d3b5a'])

  @radiusScale = d3.scale.linear()