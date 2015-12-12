class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="double-down-button">Double Down</button>
    <button class="split-button">Split</button>
    <button class="reset-button">Reset Game</button>
    <div class="cardsleft">Cards Left: <%= deck.length%></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="bet-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()
      @render()
      # $('.double-down-button').hide()
      # $('.split-button').hide()
    'click .stand-button': -> 
      @model.get('playerHand').stand()
      @render()
    'click .double-down-button': ->@model.get('playerHand').doubleDown();
    'click .reset-button': ->@model.initialize()



  initialize: ->
    @render()
    @model.on("newGame", @render, @)
    # @model.get('playerHand').checkBlackjack()


  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bet-container').html new BetView(model: @model.get 'bet').el

