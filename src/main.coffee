view = new View('#view')
table = new Table('data.csv', ->
  view.render(table.rows)

  $('[data-toggle="popover"]').popover(
    container: 'body'
    trigger: 'hover'
    html: true
  )    
)