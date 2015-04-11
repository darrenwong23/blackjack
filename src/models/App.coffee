# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'add', @playerLogic, @
    @get('playerHand').on 'stand', (->
      @dealerLogic()
    ), this

  ifBust: ->
    #if score > 21 bust
    @initialize()


  playerLogic: ->
    if Math.min(@get('playerHand').scores()[0], @get('playerHand').scores()[1]) > 21
      @ifBust()


  dealerLogic: ->
    @get('dealerHand').at(0).flip()
    while @get('dealerHand').scores()[0] < 17
      @get('dealerHand').hit()
    @whoWins()

  whoWins: ->
    if @get('dealerHand').scores()[0] > 21
      # player wins!
      console.log "player wins"
    else if @get('dealerHand').scores()[0] > @get('playerHand').scores()[0]
      #dealer wins!
      console.log "dealer wins!"
    else if @get('dealerHand').scores()[0] == @get('playerHand').scores()[0]
      console.log "TIE!"
    else
      #player wins!
      console.log "player wins"

    @initialize()


    #reinitialize everything





