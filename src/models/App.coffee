# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'bet', bet = new BetModel({startingChips: 2000, startingBet: 100})
    @newGame()

  handleBlackjack: ->
    bet = @get('bet')
    betSize = bet.getBetSize()
    setTimeout(=>
      alert 'Blackjack! Winner Winner Chicken Dinner!'
      bet.add(betSize * 1.5)
    300)
    setTimeout(=>
      @newGame()
    1000)


  handleBust: ->
    alert "You Busted. Dealer Wins." 
    @newGame()

  handledoubleDown: ->
    bet = @get('bet')
    betSize = bet.getBetSize()
    bet.addBet(betSize);


  endGame: ->
    playerHand = @get('playerHand')
    dealerHand = @get('dealerHand')
    bet = @get('bet')
    playerScore = playerHand.bestScore()
    dealerHand.dealerStand()
    betSize = bet.getBetSize()

    setTimeout(=>
      dealerScore = dealerHand.bestScore()
      if dealerHand.checkBust() is true
        alert 'Dealer Busted. Player Wins.'
        bet.add(betSize)
      else if playerScore < dealerScore
        alert 'Dealer Wins.'
        bet.remove(betSize)
      else if playerScore > dealerScore
        alert 'Player Wins.'
        bet.add(betSize)
      else 
        alert 'You Push.'
    300)

    setTimeout(=>
      @newGame()
    1000)

  newGame: -> 
    deck = @get 'deck'
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @listenTo(@get('playerHand'), 'stand', @endGame)
    @listenTo(@get('playerHand'), 'bust', @handleBust)
    @listenTo(@get('playerHand'), 'blackjack', @handleBlackjack)
    @listenTo(@get('playerHand'), 'doubleDown', @handledoubleDown)
    @trigger("newGame")
    @get('playerHand').checkBlackjack()

