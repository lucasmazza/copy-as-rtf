pygmentize = require 'pygmentize-bundled'
copy = require('copy-paste')

mapping = require './grammar-mapping'

module.exports =
  configDefaults:
    fontface: 'Monaco',
    fontsize: 16,
    style: 'tango'

  activate: ->
    atom.config.setDefaults 'copy-as-rtf',
      fontface: @configDefaults.fontface,
      fontsize: @configDefaults.fontsize,
      style: @configDefaults.style

    atom.commands.add 'atom-workspace', "copy-as-rtf:copy", => @copy()

  copy: ->
    editor = atom.workspace.getActiveTextEditor()
    grammar = editor.getGrammar()
    source = editor.getSelectedText() || editor.getText()

    return unless source?

    lang = mapping[grammar.name] || grammar.name

    opts =
      lang: lang.toLowerCase(),
      format: 'rtf',
      options:
        fontface: atom.config.get('copy-as-rtf.fontface'),
        fontsize: atom.config.get('copy-as-rtf.fontsize') * 2,
        style: atom.config.get('copy-as-rtf.style'),

    pygmentize opts, source, (err, result) ->
      if err?
        console.error(err.message)
      else
        copy.copy(result.toString())
