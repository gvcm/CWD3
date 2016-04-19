class Row
  constructor: (record) ->
    @scoreN = parseInt(record.scoreN, 10)
    @score = []
    for num in [1..5]
      str = record['score' + num]
      if str.length == 0
        score = 0
      else
        score = parseInt(str, 10)
      @score[num - 1] = score
    @total = parseInt(record.score, 10)
    @title = record.software
    @group = record.group
    @description = record.description
    @link = record.link