class window.BetView extends Backbone.View
  className: 'bet'

  template: _.template '<table>
                        <tr><td>Bank</td><td><button class="add-button">Add</button></td><td>Current Bet</td></tr>
                        <tr><td>$<%= chips %></td><td><button class="subtract-button">Subtract</button></td><td><%= currentBet %></td></tr>
                        </table>'


  events:
    'click .add-button': -> 
      @model.addBet(50)
      @render()
    'click .subtract-button': -> 
      @model.subtractBet(50)
      @render()

  initialize: -> @render()

  render: ->
    @$el.html @template @model.attributes