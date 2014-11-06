Router.configure
  layoutTemplate: "layout"

Router.map ->
  @route "reveal",
    path: "/"
    data: ->
      sections: Sections.find({parent: null}, sort: weight: 1)
  @route "admin",
    data: ->
      sections: Sections.find({parent: null}, sort: weight: 1)
  @route "adminOrder",
    data: ->
      sections: Sections.find({parent: null}, sort: weight: 1)
  @route "adminSection",
    path: "admin/section/:_id"
    data: ->
      section: Sections.findOne @params._id
