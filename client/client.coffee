Template.reveal.rendered = ->
  Meteor.setTimeout(->
    Reveal.initialize(
      loop: true
      controls: true
      progress: true
    )
  , 500)

Weights =
  beforeFirst: (firstWeight) ->
    firstWeight - 1
  between: (beforeWeight, afterWeight) ->
    (beforeWeight + afterWeight) / 2
  afterLast: (lastWeight) ->
    lastWeight + 1

UI.body.rendered = ->
  # uses the 'sortable' interaction from jquery ui
  $("#list").sortable stop: (event, ui) -> # fired when an item is dropped
    el = ui.item.get(0)
    before = ui.item.prev().get(0)
    after = ui.item.next().get(0)
    newWeight = undefined
    unless before # moving to the top of the list
      newWeight = Weights.beforeFirst(UI.getData(after).weight)
    else unless after # moving to the bottom of the list
      newWeight = Weights.afterLast(UI.getData(before).weight)
    else
      newWeight = Weights.between(UI.getData(before).weight, UI.getData(after).weight)
    Sections.update UI.getData(el)._id,
      $set:
        weight: newWeight

    return

  return

Template.adminOrder.events
  "click .remove": ->
    Sections.remove @_id