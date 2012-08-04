pusher = new Pusher('08121a40b90d18b930f5'); # Replace with your app key
channel = pusher.subscribe('bets')

channel.bind 'new_bet', (data) ->
  alert('An event was triggered with message: ' + data.message)


App = Em.Application.create()


App.Chip = Ember.View.extend
  classNames: ['chip']
  didInsertElement: ->
    @$().offset
      top: @get('num')
      left: @get('num')

App.Chips = Ember.CollectionView.extend
  itemViewClass: App.Chip
  emptyView: Ember.View.extend
    template: Ember.Handlebars.compile("No Bets")





App.chips = App.Chips.create
  content: [{num: 12},{num: 4}]
App.chips.replaceIn('body')
