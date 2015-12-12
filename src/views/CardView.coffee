class window.CardView extends Backbone.View
  className: 'card'

  templateFront: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'
  templateBack: _.template '<img src="img/card-back.png">'


  initialize: -> @render()

  render: ->
    @$el.children().detach()
    if @model.get 'revealed'
      @$el.html @templateFront @model.attributes
    else
      @$el.html @templateBack @model.attributes
    # @$el.addClass 'covered' unless @model.get 'revealed'

