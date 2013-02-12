{EventEmitter} = require 'events'

class Foo extends EventEmitter
f = new Foo()

# typical case.
# prints SOMTHING!
f.on 'something', ->
  console.log 'SOMETHING!'
f.emit 'something'

# uncaught exception in a listener
# prints CAUGHT ON EMIT!
f.on 'throwup', ->
  throw new Error 'OMG!'
try
  f.emit 'throwup'
catch err
  console.log 'CAUGHT ON EMIT!'
