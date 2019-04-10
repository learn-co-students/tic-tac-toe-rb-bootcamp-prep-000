# Tic Tac Toe in Ruby


## How it works

Ruby Tic Tac Toe is a command line executable in which a Tic Tac Toe board is represented by an array of strings. The board object is then passed to each seqential method as an argument so the helper method can interact with or introspect on the board.


A board with an "X" in the middle:
```ruby
board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
display_board(board)
```
Outputting:

```
   |   |   
-----------
   | X |   
-----------
   |   |   
```


User interaction and collected via Ruby `gets` in which each player will choose a position on the board by entering a number 1-9, representing the selected square starting from the top left as `1` to the bottom right as `9`. The game manager keeps track of the number of moves played so that a stale match is detected, as well checks each move if a player has won.
