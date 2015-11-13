// Based off of https://github.com/rvagg/node-pygmentize-bundled/blob/master/index.js
const spawn           = require('child_process').spawn
    , path            = require('path')
    , bl              = require('bl')

var pythonVersions = {}

function fromString (child, code, source) {
  var stdout = bl()
    , stderr = bl()
    , ec     = 0
    , exitClose = function () {
        if (++ec < 2)
          return

        stdout.slice()
      }

  child.stdout.pipe(stdout)
  child.stderr.pipe(stderr)

  child.on('exit', function (code) {
    if (code !== 0) {
      ec = -1
      return new Error('Error calling `winclipcopy`: ' + stderr.toString())
    }
    exitClose()
  })
  child.on('close', exitClose)

  child.stdin.write(code)
  child.stdin.end()
}

function copy (code, source) {
    execArgs = [
         '-s', source || null
     ]

  spawnCopy(execArgs, function (err, child) {
    if (err)
        return new Error('Error calling `winclipcopy`: ' + err)
    return fromString(child, code, source)
  })
}

function spawnCopy (execArgs, callback) {
  var py = path.join(__dirname, 'winclipcopy.py')
  callback(null, spawn('python', [ py ].concat(execArgs)))
}

module.exports.toRTF = copy
