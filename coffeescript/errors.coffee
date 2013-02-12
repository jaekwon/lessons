# The problem with this is that new NaiveError
# returns an Error, not a NaiveError instance.
class NaiveError extends Error
  toString: -> @constructor.name

# This works, but Object.prototype.toString(new ExtendedError)
# gives "[object Object]", which affects the output w/ console.log
class ExtendedError extends Error
  constructor: ->
    e = super
    e.name = @constructor.name
    this.message = e.message
    this.stack = e.stack
  toString: -> @constructor.name

# This goes out of the way to return an Error with __proto__
# hacked, so that (new HackedError) instanceof HackedError.
# It just doesn't work on IE or Opera...
class HackedError extends Error
  constructor: ->
    if arguments[0].makeCanonical
      @name = @constructor.name
      return
    else
      e = super
      e.__proto__ = new @constructor makeCanonical: true # could be optimized
      return e

naive = new NaiveError "naiveMessage"
console.log '\nNaive:'
console.log naive instanceof NaiveError       # false
console.log naive instanceof Error            # true
console.log naive                             # [Error: naiveMessage]

extended = new ExtendedError "extendedMessage"
console.log '\nExtended:'
console.log extended instanceof ExtendedError # true
console.log extended instanceof Error         # true
console.log extended                          # { message: 'extendedMessage',
                                              #   stack: 'ExtendedError: ... }
console.log "#{extended}"                     # ExtendedError
console.log extended.stack                    # ExtendedError: extendedMessage
                                              #     at ...

hacked = new HackedError "hackedMessage"
console.log '\nHacked:'
console.log hacked instanceof HackedError     # true
console.log hacked instanceof Error           # true
console.log hacked                            # [HackedError: hackedMessage]
console.log "#{hacked}"                       # HackedError: hackedMessage
console.log hacked.stack                      # HackedError: hackedMessage
                                              #     at ...


# Note that Object.prototype.toString may not return [object Error] in IE or Opera.                                                                                        
# console.log or other behavior may depend on Object.prototype.toString behavior.
# See http://stackoverflow.com/questions/1382107/whats-a-good-way-to-extend-error-in-javascript
if Error.prototype.__proto__
  class ErrorBase extends Error
    constructor: ->
      if arguments[0].makeCanonical
        @name = @constructor.name
      else
        e = super
        e.__proto__ = new @constructor makeCanonical: true # could be optimized
        return e

else if Error.captureStackTrace
  class ErrorBase extends Error
    constructor: (@message) ->
      Error.captureStackTrace this, @constructor
      @name = @constructor.name

else
  class ErrorBase extends Error
    constructor: ->
      e = super
      e.name = @constructor.name
      this.message = e.message
      Object.defineProperty this, 'stack', get: -> e.stack
