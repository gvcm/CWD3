class Label
  constructor: (nodes) ->
    @selection = nodes.append('text')
      .attr('opacity', 0)
      .attr('text-anchor', 'middle')
      .attr('font-size', @fontSize)
      .attr('fill', @color)
    @selection.append('tspan')
      .text(@short)
    @selection.append('tspan')
      .attr('x', 0)
      .attr('dy', @lineHeight)
      .text(@scoreN)
    Label._instance = @

  show: ->
    @selection.transition().duration(1000).attr('opacity', 1)

  hide: ->
    @selection.attr('opacity', 0)

  short: (data, index) ->
    if index < Label.shortLabels.length
      "[#{Label.shortLabels[index]}]"

  scoreN: (data, index) ->
    if data.scoreN? and data.scoreN > 0 and index < Label.shortLabels.length
      "#{data.scoreN}%"

  lineHeight: (data, index) ->
    if data.scoreN? and data.scoreN > 0 then Label.fontSizeScale(data.scoreN) * 12 else 0

  @fontSizeScale = d3.scale.log()

  fontSize: (data, index) ->
    if data.scoreN? and data.scoreN > 0 then Label.fontSizeScale(data.scoreN) * 8 else 0

  color: (data, index) ->
    return '#FFFFFF' if index == 1 or data.group == 'T'

  @shortLabels = [
    'SPEC16', 'CWGL16', 'CMAK15', 'JMOL15', 'VEST14',
    'DIAM15', 'XCRY14', 'MERC15', 'PYMO18', 'DRAW11',
    'CARI04', 'BALL08', 'LATT04', 'SCHA14', 'ATOM11',
    'SHEL15', 'RASM09', 'CHEM15', 'QUTE07', 'XTAL03',
    'CRYS07', 'POWD00', 'PLAT13', 'GRET00', 'JAMM02',
    'ORTE14', 'OSCA15', 'STRU05'
  ]