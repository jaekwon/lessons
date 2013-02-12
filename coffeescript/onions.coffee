onion1 = ->
  do ->
    return ->
      "inside"

onion2 = ->
  return ->
    "inside"

fn11 = onion1()
fn12 = onion1()
console.log fn11 == fn12

fn21 = onion2()
fn22 = onion2()
console.log fn21 == fn22
