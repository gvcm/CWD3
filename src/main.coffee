view = new View('#view')
table = new Table('data.csv', ->
  view.render(table.rows)

  $('[data-toggle="popover"]').popover(
    container: 'body'
    placement: 'top'
    trigger: 'hover'
    html: true
  )
  
  $('g').on 'click', ->
    window.open($(this).attr('href'), '_blank');
)