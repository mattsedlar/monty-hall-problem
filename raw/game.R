doors = c(1:3)

tossout = function (x,y,z) {
  if(x == y) {
    return(sample(z[which(z!=x)],1))
  } else { return(z[which(z!=x & z!=y)]) }
}

results = function(x,y) {
  if(x!=y) { return(0) }
  else { return(1) }
}

game = function(d) {
  # check if user picks a correct number
  if(d < 1 | d > 3) {
    stop("Pick a door: 1,2,3")
  }
  
  # user's door
  print(d)
  
  # now game selects a door
  game.door = sample(doors,1)
  print(game.door)
  
  # this is where the game picks the door to remove
  empty.door = tossout(d,game.door,doors)

  # game removes remaining door
  print(empty.door)
  
  results(d,game.door)
}

set.seed(1234)
simulations = replicate(10000, game(sample(doors,1)))

simulations.table = table(simulations)
