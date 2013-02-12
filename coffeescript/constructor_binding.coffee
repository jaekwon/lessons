GLOBAL.toString = -> "GLOBAL"
pass = (fn) -> fn                   # passes fn through immediately
wrap = (fn) ->                      # wraps fn into a new function
  ->
    fn.apply(this, arguments)

class Foo
  @toString = -> "Foo"              # Foo class
  toString: -> "<Foo>"              # Foo instance

  _thin = -> @
  _phat = => @

  thin: _thin
  phat: _phat

  thinInline: -> @
  phatInline: => @

  thinPassed: pass -> @
  phatPassed: pass => @

  thinWrapped: wrap -> @
  phatWrapped: wrap => @

  console.log "meta test:"
  console.log "#{@}"                # Foo
  console.log "#{_thin()}"          # GLOBAL
  console.log "#{_phat()}"          # Foo

foo = new Foo()
console.log "\n<Foo> test:"
console.log "#{foo.thin()}"         # <Foo>
console.log "#{foo.phat()}"         # Foo
console.log "#{foo.thinInline()}"   # <Foo>
console.log "#{foo.phatInline()}"   # <Foo>  .. ": =>" means constructor binding to instance
console.log "#{foo.thinPassed()}"   # <Foo>
console.log "#{foo.phatPassed()}"   # Foo    .. No constructor binding
console.log "#{foo.thinWrapped()}"  # <Foo>
console.log "#{foo.phatWrapped()}"  # Foo    .. No constructor binding

class Bar
  @toString = -> "Bar"              # Bar class
  toString: -> "<Bar>"              # Bar instance

  @::thin = -> @
  @::phat = => @

  constructor: ->
    this.thinBound = this.thin.bind(this)
    this.phatBound = this.phat.bind(this)

bar = new Bar()
console.log "\n<Bar> test:"
console.log "#{bar.thin()}"         # <Bar>
console.log "#{bar.thinBound()}"    # <Bar>
console.log "#{bar.phat()}"         # Bar
console.log "#{bar.phatBound()}"    # Bar

















dummy =
  toString: -> "dummy"
  thin:       foo.thin
  thinInline: foo.thinInline
  phat:       foo.phat
  phatInline: foo.phatInline

console.log "\ndummy test:"
console.log "#{dummy.thin()}"       # dummy
console.log "#{dummy.thinInline()}" # dummy
console.log "#{dummy.phat()}"       # Foo
console.log "#{dummy.phatInline()}" # <Foo>  .. Not surprising anymore.

dummy =
  toString: -> "dummy"
  thin:       bar.thin
  thinBound:  bar.thinBound
  phat:       bar.phat
  phatBound:  bar.phatBound

console.log "\ndummy test:"
console.log "#{dummy.thin()}"       # dummy
console.log "#{dummy.thinBound()}"  # <Bar>
console.log "#{dummy.phat()}"       # Bar
console.log "#{dummy.phatBound()}"  # Bar
