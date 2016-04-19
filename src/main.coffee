table = new Table('data.csv', ->
  view = new View('#view', table.rows)
  $('[data-view]').click(->
    view.render($(this).data('view'))
  )
)