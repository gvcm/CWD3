class Hierarchy
  constructor: (table) ->
    @data = table.rows
    console.log(@data)
    @tree = {}
    @rootName = ''
    @groupAttr = 'group'
    @nameAttr = 'name'
    @valueAttr = 'value'

  root: (rootName) ->
    @rootName = rootName
    @

  group: (groupAttr) ->
    @groupAttr = groupAttr
    @

  name: (nameAttr) ->
    @nameAttr = nameAttr
    @

  value: (valueAttr) ->
    @valueAttr = valueAttr
    @

  nodes: ->
    @tree['name'] = @rootName
    @tree['children'] = []

    for row in @data
      node = row
      node['name'] = row[@nameAttr]
      node['value'] = row[@valueAttr]
      @tree['children'].push(node)
  
    @tree

  # nodes: ->
  #   groups = {}
  #   for row in @data
  #     groupKey = row[@groupAttr]
  #     unless groups.hasOwnProperty(groupKey)
  #       groups[groupKey] = {}
  #       groups[groupKey]['name'] = groupKey
  #       groups[groupKey]['children'] = []
  #     childObject = {}
  #     for attr, value of row
  #       childObject[attr] = value
  #     groups[groupKey]['children'].push(childObject)
  #     childObject['name'] = row[@nameAttr]
  #     childObject['value'] = row[@valueAttr]
  # 
  #   @tree['name'] = @rootName
  #   @tree['children'] = (group for k, group of groups)
  #   @tree