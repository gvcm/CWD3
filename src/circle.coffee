class Circle
  constructor: (nodes) ->
    @selection = nodes.append('circle')
      .filter((data) -> !data.children)
      .attr('r', 0)
      .attr('fill', @fill)
      .attr('stroke-width', 1)
      .attr('stroke', 'black')

  radius: (data) =>
    if data.r? then Circle.linearRadiusScale(data.r) else  Circle.sqrtRadiusScale(data.scoreN)

  fill: (data) ->
    Circle.backgroundPallete(data.group)

  show: ->
    @selection.transition().duration(3000).attr('r', @radius);
    
  hide: ->
    @selection.attr('r', 0);
  
  @backgroundPallete = d3.scale.ordinal()
    .domain(['SPEC', 'CW', 'T', 'L', 'F2', 'F1', 'Z', 'C', 'D'])
    .range(['#ff0000', '#000000', '#595959', '#85898f', '#e89e78', '#3f9657', '#b3c841','#efb052', '#5d3b5a'])

  @linearRadiusScale = d3.scale.linear()
  @sqrtRadiusScale = d3.scale.sqrt()
    .domain([0, 100])
    .range([5, 5 + (Math.sqrt(100 / Math.PI) * 10)])