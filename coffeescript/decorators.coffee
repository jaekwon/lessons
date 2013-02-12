GLOBAL.toString = -> "GLOBAL"

dec = (options) ->
  (fn) ->
    #console.log "options: #{options}"
    fn.apply(this, arguments)

class Foo
  @toString = -> "Foo"              # Foo class
  toString: -> "<Foo>"              # Foo instance

  thin: -> dec('options') -> @      # Decorated
  phat: => dec('options') => @      # Bound and decorated. 'this' (<Foo>) passed through correctly.
  wrng: => dec('options') -> @      # Wrong.

foo = new Foo()
console.log ''+foo.thin()           # GLOBAL
console.log ''+foo.phat()           # <Foo>
console.log ''+foo.wrng()           # GLOBAL

###
  class Ideal

    foo: (stuff) ->
      # typical function.

    foo:= (stuff) ->
      # this function is bound...

    foo:= dec('options') (stuff) ->
      # this function is bound and decorated...
    
    foo:= (stuff) =>
      # anything with a phat arrow refers to the class. (class function!)
  ###
