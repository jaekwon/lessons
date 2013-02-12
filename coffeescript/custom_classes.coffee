# Update: Check out my jaekwon/cardamom repo.

_ = require 'underscore'

# Create a new node.
clazz = (name, base, protoFn) ->
  
  constructor = ->
    if @ instanceof constructor
      for name, method of @ when typeof method is 'function' and
        name[name.length-1] is '$' and name.length > 1
          @[name[...name.length-1]] = method.bind(@)
      console.log constructor.prototype
      constructor.prototype.constructor.apply(@, arguments)
      return @_newOverride if @_newOverride isnt undefined
      return @
    else
      return new constructor arguments...
  constructor.name = name

  if base?
    suprCtor = ->
    suprCtor.prototype = base.prototype

    protoCtor = ->
      supr = undefined
      @constructor = constructor
      Object.defineProperty @, 'super', enumerable: false, configurable: true, get: ->
        if not supr?
          supr = new suprCtor()
          # allows for simple @super.foo() vs @super.foo.call(@)
          for name, method of base.prototype when typeof method is 'function' and
            name[name.length-1] is '$' and name.length > 1
              supr[name[...name.length-1]] = method.bind(@)
        return supr
      , set: (newValue) ->
        Object.defineProperty supr, name, value: newValue
      @ # needed
    protoCtor.prototype = base.prototype
    proto = new protoCtor()
    _.extend proto, protoFn.call(constructor, base.prototype)
    constructor.prototype = proto
  else
    proto = protoFn.call(constructor)
    constructor.prototype = proto

  return constructor

Foo = clazz 'Foo', null, (supr) ->
  foo$: ->
    console.log @, @bak, @ instanceof Foo
    
Bar = clazz 'Bar', Foo, (supr) ->
  constructor: (@bar='init:bar') ->
  bak: 1

  moo$: ->
    console.log "@", @, "@constructor", @constructor, "@super", @super

  boo: ->
    console.log "@", @, "@constructor", @constructor, "@super", @super

f = new Foo()
b = new Bar()

f.foo()
b.foo()
b.moo()
bmoo = b.moo
bmoo()
bboo = b.boo
bboo()
