# PUSHER CONFIG ---------------------------------------------------------------
pusher = new Pusher('08121a40b90d18b930f5'); # Replace with your app key
channel = pusher.subscribe('bets')

channel.bind 'new_bet', (data) ->
  player = App.players.get('content').findProperty('phone_number', data.phone_number)
  chip = App.Chip.create
    position: data.position
    amount: data.amount
    player: player
  player.get('bets').pushObject(chip)

channel.bind 'new_player', (data) ->
  App.newPlayer(data)

# -----------------------------------------------------------------------------

App = Em.Application.create
  newPlayer: (data) ->
    player = App.Player.create
      color: App.availableColors()[0]
      phone_number: data.phone_number
      bets: [
        # {position: 1}
        # {position: 2}
        # {position: 3}
        # {position: 0}
      ]
    App.players.get('content').pushObject(player)

window.App = App




# VIEWS --------------------------------

App.Chip = Ember.View.extend
  template :Ember.Handlebars.compile """
    {{view.content.position}}
  """
  classNames: ['chip']
  didInsertElement: ->
    pos = @get('content').position
    offset = {x: 97, y:300}
    chip_offset = {x: -15, y: -15}

    cell_height = 78
    cell_width = 63

    x_pos = Math.floor((pos-1) / 3) * cell_width
    y_pos = -((pos-1) % 3) * cell_height

    if pos > 0
      @$().offset
        top: offset.y + chip_offset.y + y_pos
        left: offset.x + chip_offset.x + x_pos
    else
      @$().offset
        top: offset.y + chip_offset.y - 80
        left: offset.x + chip_offset.x - 60



App.Player = Ember.View.extend
  money: 200
  template: Ember.Handlebars.compile """
    {{view.content.phone_number}}
    {{view view.Chips}}
  """
  classNameBindings: ['content.color']

  Chips: Ember.CollectionView.extend
    itemViewClass: App.Chip
    emptyView: Ember.View.extend
      template: Ember.Handlebars.compile("No Bets")
    contentBinding: 'parentView.content.bets'


App.Players = Ember.CollectionView.extend
  tagName: 'ul'
  itemViewClass: App.Player
  emptyView: Ember.View.extend
    template: Ember.Handlebars.compile("No Players")



# APP HELPERS -------------------------------

App.colors = [
  'red'
  'blue'
  'green'
  'brown'
  'orange'
]

App.availableColors = ->
  App.colors.diff( App.players.get('content').mapProperty('color') )

Array.prototype.diff = (a) ->
  return this.filter( (i) ->
    return !(a.indexOf(i) > -1)
  )

App.allBets = ->
  results = []
  App.players.get('content').forEach (item) ->
    item.get('bets').forEach (item) ->
      results.push(item)
  return results





# SETUP -------------------------------------

App.players = App.Players.create
  content: []
App.players.appendTo('body')
