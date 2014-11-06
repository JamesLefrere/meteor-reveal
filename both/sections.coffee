sectionSchema = new SimpleSchema(
  title:
    type: String
    optional: true
  body:
    type: String
    label: "Body (allows HTML)"
    optional: true
    autoform:
      type: "textarea"
      rows: 6
  parent:
    type: String
    optional: true
    autoform:
      firstOption: "Top-level"
      options: ->
        _.map Sections.find().fetch(), (section) ->
          label: section.title
          value: section._id
  weight:
    type: Number
    optional: true
    decimal: true
)

@Sections = new Mongo.Collection "sections"

@Sections.attachSchema sectionSchema

@Sections.helpers(
  subsections: ->
    Sections.find({parent: @_id}, sort: weight: 1)
)