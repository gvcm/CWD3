class Hierarchy
  constructor: (table) ->
    @data = table.rows
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
    groups = {}
    for row in @data
      groupKey = row[@groupAttr]
      unless groups.hasOwnProperty(groupKey)
        groups[groupKey] = {}
        groups[groupKey]['name'] = groupKey
        groups[groupKey]['children'] = []
      groups[groupKey]['children'].push(
        name: row[@nameAttr]
        value: row[@valueAttr]
      )
    @tree['name'] = @rootName
    @tree['children'] = (group for k, group of groups)
    @tree