class Row
  constructor: (record) ->
    @scoreN = parseInt(record.scoreN, 10)
    @value = (Row.weightScale(@scoreN) + 1) # pack layout
    @score = []
    @scoreXN = []
    for num in [1..5]
      str = record['score' + num]
      @score[num - 1] = if str.length == 0 then 0 else parseInt(str, 10)
      str = record['score' + num + 'N']
      @scoreXN[num - 1] = if str.length == 0 then 0 else parseInt(str, 10)
    @total = parseInt(record.score, 10)
    @title = record.software
    @group = record.group
    @description = record.description
    @link = record.link
    @criteriaKeys = []
    for k, _ of Criteria.hashMap
      @criteriaKeys.push(k) if record[k] == '1'
    @x = 0
    @y = 0

  @weightScale = d3.scale.pow().exponent(0.8)