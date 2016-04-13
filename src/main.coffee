view = new View('#view')
table = new Table('data.csv', ->
  nodes = new Hierarchy(table)
    .group('group')
    .name('title')
    .nodes()
  view.render(nodes)

  $('[data-toggle="popover"]').popover(
    container: 'body'
    trigger: 'hover'
    html: true
  )
  
  $('g').hover((->
    $circle = $(this).find('circle')
    $circle.data('previous-stroke', $circle.attr('stroke'))
           .data('previous-stroke-width', $circle.attr('stroke-width'))
           .attr('stroke', 'black')
           .attr('stroke-width', 3)
  ),(->
    $circle = $(this).find('circle')
    $circle.attr('stroke', $circle.data('previous-stroke'))
           .attr('stroke-width', $circle.data('previous-stroke-width'))
  ))
  
  $('g').on 'click', ->
    if parseInt($(this).data('index')) > 0
      window.open($(this).attr('href'), '_blank');
)