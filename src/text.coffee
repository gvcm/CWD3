class Text

  build: (parent) ->
    @element = parent.append('text')
      .attr('opacity', 0)
      .attr('text-anchor', 'middle')
      .attr('font-size', @fontSize)
      .attr('fill', @color)
    @element.append('tspan')
      .text(@textLabel)
    @element.append('tspan')
      .attr('x', 0)
      .attr('dy', @textLineHeight)
      .text(@textWeight)

  show: ->
    @element.transition().duration(3000).attr('opacity', 1)

  textLabel: (data, index) ->
    if index < Text.shortLabels.length
      "[#{Text.shortLabels[index]}]"

  textWeight: (data, index) ->
    if data.weight? and data.weight > 0 and index < Text.shortLabels.length
      "#{data.weight}%"

  textLineHeight: (data, index) ->
    if data.weight? and data.weight > 0 then Text.fontSizeScale(data.weight) * 12 else 0

  @fontSizeScale = d3.scale.log()

  fontSize: (data, index) ->
    if data.weight? and data.weight > 0 then Text.fontSizeScale(data.weight) * 8 else 0

  color: (data, index) ->
    return '#FFFFFF' if index == 1 or data.group == 'T'

  @shortLabels = [
    'SPEC16'
    'CWGL16'
    'CMAK15'
    'JMOL15'
    'VEST14'
    'DIAM15'
    'XCRY14'
    'MERC15'
    'PYMO18'
    'DRAW11'
    'CARI04'
    'BALL08'
    'LATT04'
    'SCHA14'
    'ATOM11'
    'SHEL15'
    'RASM09'
    'CHEM15'
    'QUTE07'
    'XTAL03'
    'CRYS07'
    'POWD00'
    'PLAT13'
    'GRET00'
    'JAMM02'
    'ORTE14'
    'OSCA15'
    'STRU05'
  ]