# PUSHER CONFIG ---------------------------------------------------------------
pusher = new Pusher('08121a40b90d18b930f5'); # Replace with your app key
channel = pusher.subscribe('bets')

channel.bind 'new_bet', (data) ->
  player = App.players.get('content').findProperty('phone_number', data.phone_number)
  chip = App.Chip.create
    position: data.position
    amount: data.amount
    player: player
  player.addBet(chip)
  player.get('bets').pushObject(chip)
  player.subtractMoney(data.amount)

channel.bind 'new_player', (data) ->
  App.newPlayer(data)

window.spinToLow = true

window.spinWheel = ->
  countDown()

  if window.spinToLow == true
    spinToDegrees = 6000
    window.spinToLow = false
  else
    window.spinToLow = true
    spinToDegrees = 0

  wheel =  $('#inner')
  wheel.css('-webkit-transform', 'rotate(' + spinToDegrees + 'deg)').
        css( '-webkit-transition', '20s ease-out')

window.countDown = ->
  window.timeRemaining ||= 200
  window.timeRemaining   -= 10
  if window.timeRemaining == 0
    window.endGame()
  else
    setTimeout(window.countDown, 10)

key 'a', spinWheel


window.endGame = () ->
  winningNumber = Math.floor((Math.random() * 37))
  matchingBets = App.allBets().filterProperty('position', winningNumber)

  matchingBets.forEach (bet) ->
    player = bet.get('player')
    winnings = 35 * bet.get('amount')
    player.addMoney winnings
  alert "Number " + winningNumber + " won, congratulations: "


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
    {{view.content.amount}}
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

    rand = {x: Math.random()*20, y: Math.random()*40}

    if pos > 0
      @$().offset
        top: offset.y + chip_offset.y + y_pos - rand.y
        left: offset.x + chip_offset.x + x_pos + rand.x
    else
      @$().offset
        top: offset.y + chip_offset.y - 80 - rand.y
        left: offset.x + chip_offset.x - 60 + rand.x



App.Player = Ember.View.extend
  money: 200
  addMoney: (amount) ->
    this.set('money',  this.get('money') + amount)

  subtractMoney: (amount) ->
    this.set('money',  this.get('money') - amount)

  template: Ember.Handlebars.compile """
    <h3>{{view.content.phone_number}}</h3>
    <h4>£{{view.content.money}}</h4>
    {{view view.Chips}}
    {{view.content.betCount}} bets
  """
  classNameBindings: ['content.color']
  bets: []
  betCount: 0
  addBet: (bet) ->
    @get('bets').pushObject(bet)
    @set('betCount', @get('betCount')+1)
    @rerender()
    console.log @get('betCount')



  Chips: Ember.CollectionView.extend
    itemViewClass: App.Chip
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
  'bright_blue'
  'purple'
  'yellow'
  'red2'
  'blue2'
  'green2'
  'brown2'
  'orange2'
  'bright_blue2'
  'purple2'
  'yellow2'
  'red3'
  'blue3'
  'green3'
  'brown3'
  'orange3'
  'bright_blue3'
  'purple3'
  'yellow3'
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

App.newPlayer({money: 200, phone_number: '1'})
App.newPlayer({money: 200, phone_number: '2'})
App.newPlayer({money: 200, phone_number: '3'})
App.newPlayer({money: 200, phone_number: '4'})
App.newPlayer({money: 200, phone_number: '5'})
App.newPlayer({money: 200, phone_number: '6'})
App.newPlayer({money: 200, phone_number: '7'})
App.newPlayer({money: 200, phone_number: '8'})
App.newPlayer({money: 200, phone_number: '1'})
App.newPlayer({money: 200, phone_number: '2'})
App.newPlayer({money: 200, phone_number: '3'})
App.newPlayer({money: 200, phone_number: '4'})
App.newPlayer({money: 200, phone_number: '5'})
App.newPlayer({money: 200, phone_number: '6'})
App.newPlayer({money: 200, phone_number: '7'})
App.newPlayer({money: 200, phone_number: '8'})
