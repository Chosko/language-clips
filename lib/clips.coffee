ClipsView = require './clips-view'
{CompositeDisposable} = require 'atom'

module.exports = Clips =
  clipsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @clipsView = new ClipsView(state.clipsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @clipsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'clips:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @clipsView.destroy()

  serialize: ->
    clipsViewState: @clipsView.serialize()

  toggle: ->
    console.log 'Clips was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
