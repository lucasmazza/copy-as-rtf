pygmentize = require 'pygmentize-bundled'
copy = require('copy-paste')

mapping = require './grammar-mapping'

module.exports =
  config:
    fontface:
      type: 'string'
      default: 'Monaco'
    fontsize:
      type: 'integer'
      default: 16
    style:
      type: 'string'
      default: 'tango'

  activate: ->
    atom.config.set('copy-as-rtf.fontface', atom.config.get("fontface"))
    atom.config.set('copy-as-rtf.fontsize', atom.config.get("fontsize"))
    atom.config.set('copy-as-rtf.style', atom.config.get("style"))

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
