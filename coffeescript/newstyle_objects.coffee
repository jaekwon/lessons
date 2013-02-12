# The purpose of this script is to demonstrate a new style of declaring methods in CoffeeScript classes.
# Benefits:
#  - Avoid the usage of 'name: =>' for bound-method declarations, which is inconsistent with the rest of CoffeeScript.
#  - Decorators work flawlessly with bound methods.
#  - Declarative syntax for methods, for more literate code.

{clone, extend} = require 'underscore'
GLOBAL.toString -> 'GLOBAL'

# Here's a dummy decorator for demonstration purposes.
decorator = (fn) ->
  ->
    fn.apply(this, arguments)

# Base class for new-style classes.
class Base

  @instance = (methods) ->
    # create a new @__methods for each subclass
    if @__methods__class != this
      @__methods__class = this
      @__methods = if @__methods then clone(@__methods) else {}
    extend @__methods, methods
    extend this::, methods

  @static = (methods) ->
    extend this::, methods

  @class = (methods) ->
    extend this, methods

  constructor: ->
    @bindInstanceMethods()

  bindInstanceMethods: =>
    if not @__methods__bound
      @__methods__bound = true
      for name, func of @constructor.__methods
        @[name] = func.bind @

class Foo extends Base

  @instance
    info:     -> "Foo.info:#{this}"
    toString: -> "<Foo>"
    clazz:    => "clazz:#{this}"  # fat arrow now binds to Foo.

  @class
    toString: -> "[class:Foo]"

  @static
    static:   -> "static:#{this}" # depends on how the function is invoked

class Bar extends Foo

  @instance
    info:     decorator -> "Bar.info:#{this}" # binding works even with decorators
    toString: -> "<Bar>"

  @class
    toString: -> "[class:Bar]"
    
f = new Foo()
f_info = f.info
f_static = f.static
console.log f.info()    # Foo.info:<Foo>
console.log f_info()    # Foo.info:<Foo>
console.log f.clazz()   # clazz:[class:Foo]
console.log f.static()  # static:<Foo>
console.log f_static()  # static:[object global]

b = new Bar()
b_info = b.info
console.log b.info()    # Bar.info:<Bar>
console.log b_info()    # Bar.info:<Bar>
console.log b.clazz()   # clazz:[class:Foo]
