# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @newGame()

 
  handleBust: ->
    alert "You Busted. Dealer Wins." 
    @newGame()

  endGame: ->
    playerHand = @get('playerHand')
    dealerHand = @get('dealerHand')
    playerScore = playerHand.bestScore()
    dealerHand.dealerStand()

    setTimeout(=>
      dealerScore = dealerHand.bestScore()
      if dealerHand.checkBust() is true
        alert 'Dealer Busted. Player Wins.'
      else if playerScore < dealerScore
        alert 'Dealer Wins.'
      else if playerScore > dealerScore
        alert 'Player Wins.'
      else 
        alert 'You Push.'
    300)

    setTimeout(=>
      @newGame()
    1000)

  newGame: -> 
    console.log "Reset"
    deck = @get 'deck'
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @listenTo(@get('playerHand'), 'stand', @endGame)
    @listenTo(@get('playerHand'), 'bust', @handleBust)
    @trigger("newGame")
