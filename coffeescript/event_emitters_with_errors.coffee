EE = require('events').EventEmitter

class Foo
  foo: 1

makeEventEmitter = (obj, attach=true) ->
  emitter = new EE()
  obj.emitter = emitter if attach

  for own key, value of (EE::) then do (key) ->
    obj[key] = ->
      emitter[key](arguments...)

makeEventEmitter(Foo)

Foo.on 'test', ->
  throw new Error('test error')

try
  Foo.emit 'test', 'a', 'b'
catch error
  console.log "caught error", error

try
  Foo.emit 'error', 'a', 'b'
catch error
  console.log "caught error", error

Foo.on 'error', ->
  console.log "event error", arguments

try
  Foo.emit 'test', 'a', 'b'
catch error
  console.log "caught error", error

try
  Foo.emit 'error', 'a', 'b'
catch error
  console.log "caught error", error
