view = new View('#view')
table = new Table('data.csv', ->
  nodes = new Hierarchy(table)
    .group('group')
    .name('title')
    .value('weight')
    .nodes()
  view.render(nodes)

  $('[data-toggle="popover"]').popover(
    container: 'body'
    trigger: 'hover'
    html: true
  )
  
  $('g').hover((->
    $circle = $(this).find('circle')
    $circle.attr('stroke', 'black')
    $circle.attr('stroke-width', 3)
  ),(->
    $circle = $(this).find('circle')
    $circle.attr('stroke', 'transparent')
    $circle.attr('stroke-width', 0)
  ))
  
  $('g').on 'click', ->
    if parseInt($(this).data('index')) > 0
      window.open($(this).attr('href'), '_blank');
)