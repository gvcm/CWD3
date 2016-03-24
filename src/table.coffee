class Table
  constructor: (file, callback) ->
    @file = file
    @rows = []
    @callback = callback
    d3.csv(file, @load.bind(@))
  
  load: (data) ->
    data.forEach(@createRow.bind(@))
    @callback()
    
  createRow: (record) ->
    @rows.push new Row(record)