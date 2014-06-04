pygmentize = require 'pygmentize-bundled'
copy = require 'copy-paste'

module.exports =
  activate: ->
    atom.workspaceView.command 'copy-as-rtf:copy', => @copy()

  copy: ->
    editor = atom.workspace.getActiveEditor()
    grammar = editor.getGrammar()
    source = editor.getSelectedText() || editor.getText()

    opts =
      lang: grammar.name.toLowerCase(),
      format: 'rtf',
      options:
        fontface: 'Monaco',
        style: 'tango',

    text = pygmentize opts, source, (err, result) ->
      rtf = result.toString()

      if err?
        console.error(err.message)
      else
        copy.copy(rtf)
