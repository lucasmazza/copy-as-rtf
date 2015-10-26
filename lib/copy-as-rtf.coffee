pygmentize = require 'pygmentize-bundled'
copy = require('copy-paste')

mapping = require './grammar-mapping'

module.exports =
  config:
    fontface:
      title: 'Font Face'
      type: 'string'
      default: 'Monaco'
    fontsize:
      title: 'Font Size'
      type: 'integer'
      default: 16
    style:
      title: 'Style'
      type: 'string'
      default: 'tango'

  activate: ->
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
        advice = if err.message.indexOf('python -V') > 0 then '\n\rPlease try to install Python in your system' else ''
        atom.notifications.addError('Package error (copy-as-rtf)' + advice, {detail : err.message})
      else
        copy.copy(result.toString())
