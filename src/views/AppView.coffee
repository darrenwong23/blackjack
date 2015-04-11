class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': (->
      @model.get('playerHand').stand()
      @$('button').prop 'disabled', true
    )


  initialize: ->
    @render()
    @model.on 'change', (->
      context = @
      @$('button').prop 'disabled', true
      setTimeout context.render.bind(@), 2000

    ), @




  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

