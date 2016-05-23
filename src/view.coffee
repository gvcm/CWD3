class View
  constructor: (selector, data) ->
    @$container = $(selector)
    @$container.height($(window).height() - @$container.position().top)
    @data = data
    @width = @$container.width()
    @height = @$container.height() * 2
    @selection = d3.select(selector)
      .append('svg')
      .attr('width', @width)
      .attr('height', @height)

    @currentTab = null
    @render()

  setHeight: (height) ->
    @$container.height(height)
    @selection.attr('height', height)
    
  render: (tab) ->
    tab = 'default' unless tab?
    d3.selectAll('g').remove()
    d3.selectAll('.volatile').remove()
    @top()
    @[tab + 'Tab']()
    @currentTab = tab

    $('[data-toggle="popover"]').popover(
      container: 'body'
      trigger: 'hover'
      html: true
    )

  update: ->
    @render(@currentTab)

  @showRef: ->
    $('#show-ref').prop('checked')

  top: ->
    window.scrollTo(0, 0)
    
  center: ->
    window.scrollTo(0, @height / 4)

  scrollLock: (lock) ->
    $('body')
      .css('overflow-x', 'hidden')
      .css('overflow-y', (if lock then 'hidden' else 'scroll'))

  defaultTab: ->
    total = new Text(@selection)
    @center()
    @scrollLock(true)
    bubble = new Bubble(@selection.selectAll('g').data(@data).enter())
    bubble.byDefault(@width, @height)
      .on('forceEnd', =>
        boundary = bubble.boundary()
        total.translate(((boundary.x1 + boundary.x2) / 2.0) - 15, boundary.y2 + 50)
        total.text("TOTAL=#{bubble.total()}")
        @scrollLock(false)
      )

  categoryTab: ->
    @top()
    @scrollLock(true)
    bubble = new Bubble(@selection.selectAll('g').data(@data).enter())
    bubble.byCategory(@width, @height)
    bubble.show()
    @setHeight(14000)
    @scrollLock(false)

  scoreTab: ->
    @top()
    total = new Text(@selection)
    positionY = 250

    for k,v of Criteria.hashMap
      criteriaText = new Text(@selection)
      criteriaText.text(v)
      criteriaText.translate(50, positionY)
      criteriaText.show()
      positionY += 100
    
    @setHeight(positionY + 250)
    
    positionX = 500
    criteriaText = new Text(@selection)
    criteriaText.text('TOTAL')
    criteriaText.translate(positionX, 200)
    positionX += 100
    
    for n in [1...6] by 1
      criteriaText = new Text(@selection)
      criteriaText.text('score ' + n)
      criteriaText.translate(positionX, 200)
      criteriaText.show()
      positionX += 100

  getDataGroupedByCriteria: ->
    dataGroup = {}
    for k,_ of Criteria.hashMap
      dataGroup[k] = [] unless dataGroup[k]?
      for row in @data
        clonedRow = {}
        for f,v of row
          clonedRow[f] = v
        if k in row.criteriaKeys
          dataGroup[k].push(clonedRow)
    dataGroup

  buildBubbleGroups: (data) ->
    counter = 0
    marginSize = 50
    numberOfColumns = Math.ceil((@width - (2 * marginSize)) / 600)
    columnSize = @width / numberOfColumns
    numberOfRows = Math.ceil(@height / 500)
    rowSize = @height / numberOfRows
    maxY = 0

    for k,d of data
      row = Math.floor(counter / numberOfColumns)
      column = counter % numberOfColumns

      counter += 1
      nodeGroup = @selection.append('g')
        .attr('class', 'bubble-' + counter)
        .attr('transform', =>
          rx = column * columnSize + (if column > 0 then 0 else marginSize)
          ry = row * rowSize + (2 * marginSize)
          maxY = ry if maxY < ry
          "translate(#{rx},#{ry})")

      bubble = new Bubble(nodeGroup.selectAll('g.bubble').data(d).enter())
      bubble.byDefault(columnSize, rowSize)

      criteriaText = new Text(nodeGroup)
      criteriaText.text(Criteria.hashMap[k])
      criteriaText.translate(marginSize, 0)
      criteriaText.show()
      @scrollLock(false)
    
    @setHeight(maxY + rowSize)

  criteriaTab: ->
    @buildBubbleGroups(@getDataGroupedByCriteria())

  popularityTab: ->
    data = @getDataGroupedByCriteria()

    sortable = []
    for k,d of data
      sortable.push([k,d.length])
    sortable.sort((a,b) -> a[1] - b[1])
    sortable.reverse()
    
    sortedData = {}
    for j in sortable
      k = j[0]
      sortedData[k] = data[k]
      
    @buildBubbleGroups(sortedData)