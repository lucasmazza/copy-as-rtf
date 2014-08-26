pygmentize = require 'pygmentize-bundled'
copy = require('copy-paste').silent()

mapping = require './grammar-mapping'

module.exports =
  configDefaults:
    fontface: 'Monaco',
    style: 'tango'

  activate: ->
    atom.config.setDefaults 'copy-as-rtf',
      fontface: @configDefaults.fontface,
      style: @configDefaults.style

    atom.workspaceView.command 'copy-as-rtf:copy', => @copy()

  copy: ->
    editor = atom.workspace.getActiveEditor()
    grammar = editor.getGrammar()
    source = editor.getSelectedText() || editor.getText()

    return unless source?

    lang = mapping[grammar.name] || grammar.name

    opts =
      lang: lang.toLowerCase(),
      format: 'rtf',
      options:
        fontface: atom.config.get('copy-as-rtf.fontface'),
        style: atom.config.get('copy-as-rtf.style'),

    pygmentize opts, source, (err, result) ->
      if err?
        console.error(err.message)
      else
        copy.copy(result.toString())
