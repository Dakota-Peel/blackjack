class window.BetModel extends Backbone.Model
  initialize: (params) ->
    @set
      chips: params.startingChips
      currentBet: params.startingBet

  add: (value)->
    @set('chips', (@get('chips') + value))

  remove: (value)->
    @set('chips', (@get('chips') - value))

  addBet: (value) ->
    currentBet = @get('currentBet')
    chips = @get('chips')
    if (currentBet + value) >= chips
      newBet = chips
    else
      newBet = currentBet + value
    @set('currentBet', newBet)

  subtractBet: (value) ->
    currentBet = @get('currentBet')
    chips = @get('chips')
    if (currentBet - value) <= 50
      newBet = 50
    else
      newBet = currentBet - value
    @set('currentBet', newBet)

  getBetSize: ->
    return @get('currentBet')
