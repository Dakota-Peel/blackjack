class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()
    @checkBust()


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  bestScore: ->
    scores = @scores()
    if scores[1]<=21 then scores[1] else scores[0]

  checkBust: ->
    if @bestScore() > 21
      @trigger("bust", @)
      true

  stand: ->
    @trigger("stand", @)

  dealerStand: ->
    @at(0).flip()
    @hit() while @bestScore() < 17
    #Dealer Hits on Soft 17
    if @minScore == 17
      console.log "Soft 17. Hit again"
      @hit()

  checkBlackjack: ->
    console.log(@bestScore())
    if @bestScore() == 21
      setTimeout(-> 
        alert "Blackjack! Winner Winner Chicken Dinner"
        @trigger("newGame", @)
        , 200)

     



