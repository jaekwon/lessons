
fruitlist = ['apple', 'pear']

# Case 1 (Original)
for fruit in fruitlist
  console.log fruit

# case 2 (Wrong)
callbacks = []
# js: var fruit = undefined;
# js: var i = undefined;
# js: for (i=0; i<fruitlist.length; i++) {
for fruit in fruitlist
  # js: fruit = fruitlist[i]
  callbacks.push ->
    console.log fruit # refers to the same 'fruit' variable.

# This won't print 'apple', but 'pear' twice.
callback() for callback in callbacks

# Case 3 (Solution)
callbacks = []
for fruit in fruitlist then do (fruit) ->
  callbacks.push -> console.log fruit

callback() for callback in callbacks
