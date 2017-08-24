# Tic Tac Toe in Ruby

## Overview

We'll build a two-player CLI version of Tic Tac Toe by defining a set of methods to encapsulate the game logic. 

## Objectives

1. Build and use helper methods within the Tic Tac Toe application
2. Write a method that is responsible for the game loop in Tic Tac Toe
3. Code the main executable file that will run the game in the CLI 

## The Final Product

When complete, the game will look something like this when played:

<iframe width="100%" height="100%" src="https://www.youtube.com/embed/e4TMZ0f6qoI" frameborder="0" allowfullscreen></iframe>

### Use Your Previous Tic Tac Toe Code

If you've been following along with the progression of Tic Tac Toe labs you've probably already built lots of the methods required to solve this lab. As you solve this lab, when you encounter a requirement you have previously solved, like defining the `WIN_COMBINATIONS` constant, or the `#display_board` method, you should take a second and find your old code. The ability to recognize previously solved problems and integrate a known solution is crucial to programming (and problem solving in general). Us programmers, we call that "Copy and Pasting."

### Project Structure

```
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── bin
│   └── tictactoe
├── lib
│   └── tic_tac_toe.rb
└── spec
    ├── 01_tic_tac_toe_spec.rb
    ├── 02_play_spec.rb
    ├── 03_cli_spec.rb
    └── spec_helper.rb
```

#### Gemfile and Rakefile

These files setup some tools and gems for our project and can mostly be ignored. Make sure to run `bundle` before starting this project so that you have all the required gems.

#### `bin/tictactoe`

This is our main executable and will be how we run our game.

#### `lib/tic_tac_toe.rb`

All of our game methods will be coded here.

#### `spec`

There are three test files that should be completed in order. `01_tic_tac_toe_spec.rb` sets tests for our helper methods. `02_play_spec.rb` tests the main `#play` method. `03_cli_spec.rb` tests the CLI.

### Your Tic Tac Toe Game

There are infinite ways to build Tic Tac Toe. We, however, have been building up to a very specific structure with the methods we've been building throughout this course. We'll be using many of those methods here. These methods represent the basic requirements and logic of the game.

Why build and utilize the helper methods we've been constructing?

Let's take a look at what it would require to print out a board three times, without any helper methods:

```ruby
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
```

Now, let's take a look at the same task, encapsulated into a method that we can simply call, or invoke, three times.

```ruby
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

display_board(board)
display_board(board)
display_board(board)
```

When our logic is well encapsulated by individual methods everything about our code is easier. We can re-use the same logic again and again, painlessly.

You'll approach building Tic Tac Toe in this manner, first defining helper methods according to the test requirements and then slowly putting them together to define the complete play logic.

You'll then use this play method within a CLI and build a fully functioning 2 player Tic Tac Toe CLI in Ruby!

### Game Conventions

We'll be representing a Tic Tac Toe board using an array of `" "` strings. We'll pass this board to every method as an argument so the helper methods can interact with or introspect on the board.

We'll be getting user input via `gets` and a player will choose a position on the board by entering 1-9. Our program will then fill out the appropriate position on the board with the player's token. The term 'position' will refer to the spot on the board as the player sees it (1-9).

We will keep track of which player's turn it is and how many turns have been played. We will check to see, at every turn, if there is a winner. If there is a winner, we'll congratulate them. If there is a tie, we will inform our players.

## Instructions

### Helper Methods

Open up `lib/tic_tac_toe.rb`. You'll be coding your helper methods here. Run the tests for these methods by typing `rspec spec/01_tic_tac_toe_spec.rb` in the terminal. Use the test output, along with the guidelines below, to build these methods.

#### `WIN_COMBINATIONS`

Define a constant in `lib/tic_tac_toe.rb` `WIN_COMBINATIONS` and set it equal to a nested array filled with the index values for the various win combinations in tic tac toe.

```ruby
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5]  # Middle row
  # ETC, an array for each win combination
]
```

#### `#display_board`

Define a method that prints the current board representation based on the `board` argument passed to the method.

An empty board would be:

```ruby
board = [" "," "," "," "," "," "," "," "," "]
display_board(board)
```
Outputting:

```
   |   |   
-----------
   |   |   
-----------
   |   |   
```

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

#### `#input_to_index`

Once the user inputs where they would like to go on the board, we then have to convert this to the board index multiple times. Instead of doing that in a lot of places, we can remove this repetitive code and put it in this helper method. This method takes the user_input (which is a string), converts it to an Integer, and subtracts 1. Remember that, from the player's point of view, the board contains spaces 1-9. But, an array's indexes start their count at 0.

#### `#move`

Your `#move` method must take in three arguments: **1)** the board array, **2)** the index in the board array that the player would like to fill out with an "X" or and "O", and **3)** the player's character (either "X" or "O"). We previously had you write this method with a default argument of "X" for the third argument, but that is no longer needed.

#### `#position_taken?`

The `#position_taken?` method will be responsible for evaluating the position selected by the user against the Tic Tac Toe board and checking to see whether or not that index on the board array is occupied. If the user would like to fill out position 1, our `#position_taken?` method will check to see if that board index is vacant or if it contains an "X" or an "O". If the position is free, the method should return `false` (i.e. "not taken"), otherwise it will return `true`.

#### `#valid_move?`

Build a method `valid_move?` that accepts a board and an index to check and returns `true` if the move is valid and `false` or `nil` if not. A valid move means that the submitted position is:

1. Present on the game board.
2. Not already filled with a token.

#### `#turn`

Build a method `#turn` to encapsulate the logic of a single complete turn composed of the following routine:

1. Asking the user for their move by position 1-9.
2. Receiving the user input.
3. Convert user input to an index
4. If the move is valid, make the move and display board.
5. Otherwise (that is, if the move is invalid) ask for a new position until a valid move is received.

All these procedures will be wrapped into our `#turn` method. However, the majority of the logic for these procedures will be defined and encapsulated in individual methods which you've already built.

You can imagine the pseudocode for the `#turn` method:

```
ask for input
get input
convert input to index
if move is valid
  make the move for index and show board
else
  ask for input again until you get a valid move
end
```

#### `#turn_count`

This method takes in an argument of the board array and returns the number of turns that have been played.

#### `#current_player`

The `#current_player` method should take in an argument of the game board and use the `#turn_count` method to determine if it is `"X"`'s turn or `"O"`'s.

#### `#won?`

Your `#won?` method should accept a board as an argument and return false/nil if there is no win combination present in the board and return the winning combination indexes as an array if there is a win. Use your `WIN_COMBINATIONS` constant in this method.

#### `#full?`

The `#full?` method should accept a board and return true if every element in the board contains either an "X" or an "O".

#### `#draw?`

Build a method `#draw?` that accepts a board and returns true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won.

#### `#over?`

Build a method `#over?` that accepts a board and returns true if the board has been won, is a draw, or is full.

#### `#winner`

The `#winner` method should accept a board and return the token, "X" or "O" that has won the game given a winning board.

### Putting it all together: the `#play` method

#### `#play`

The play method is the main method of the tic tac toe application and is responsible for the game loop. A tic tac toe game must allow players to take turns, checking if the game is over after every turn, and at the conclusion of the game, whether because it was won or because it was a draw, reporting to the user the outcome of the game. You can imagine the pseudocode:

```
until the game is over
  take turns
end

if the game was won
  congratulate the winner
else if the game was a draw
  tell the players it has been a draw
end
```

Run the tests for the `#play` method by typing `rspec spec/02_play_spec.rb` in your terminal.

#### Reading the `#play` test specs and output

It'll help you a bit to understand how the tests are written for `#play` and what the failure output means. Open up `spec/02_play_spec.rb`. You'll see the first test block:

```ruby
it 'asks for players input on a turn of the game' do
  board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  allow($stdout).to receive(:puts)
  allow(self).to receive(:over?).and_return(false, true)

  expect(self).to receive(:gets).at_least(:once).and_return("1")

  play(board)
end
```

This test is built to confirm that your implementation of the `#play` method will at some point ask the user for input via the `gets` method. In order to ensure this requirement of the play method, our test needs to set up some conditions and expectations.

1 . First, we have a sample game board, `board`, as it would look at the start of the game, entirely empty.

```ruby
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
```

2 . We state that any output to `$stdout` (which is how Ruby sends output to your terminal) should basically be ignored. Otherwise when we run our tests, we'll see all of our program's output and it'll be super confusing.

```ruby
allow($stdout).to receive(:puts)
```

3 . Our play method is going to involve looping. The test suite is going to ensure that when you build your game loop, you use the `#over?` method as a condition of when to end the loop. When we call `#play` in our test this loop will never end because there is no player input and no one ever wins the game in most of our tests. This would create an infinite loop in our test. So to avoid this, we fake the behavior of `#over?`, making sure it returns false the first time it is called and true the second.

```ruby
allow(self).to receive(:over?).and_return(false, true)
```

In this test it is as though the `#over?` method was defined to automatically return `false` the first time it is called and `true` all other times. Because the `#play` loop depends on `#over?`, when `#over?` returns true, the loop should end.

In our tests, we can stub the functionality of any method to behave exactly as we would like for this test to function and create the conditions that allow us to specify functionality. This technique of faking or hardcoding the return value and behavior of a method is called Mocking or Stubbing. It's a bit of an advanced technique in testing and for the most part, you don't need to worry about it.

4 . The main expectation of our test is that when `#play` is called, at some point the user will be prompted for input via the `gets` method. We set exactly this expectation:

```ruby
expect(self).to receive(:gets).at_least(:once).and_return("1")
```

The final bit of that, `and_return("1")`, states that when `gets` is called and the expectation is met, the call to `gets` should also be stubbed and return "1".

5 . Finally, after setting up the expectations of the behavior of `#play`, the test suite evokes the method. All expectations set must be met by the termination of that method call.

```ruby
play(board)
```


With a non-functioning `#play` method, let's look at the output of the failure.

```ruby
def play(board)
end
```

If we ran the test suite against that code in `lib/tic_tac_toe.rb`, we'd see.

```
1) ./lib/tic_tac_toe.rb #play asks for players input on a turn of the game
     Failure/Error: expect(self).to receive(:gets).at_least(:once).and_return("1")
       (#<RSpec::ExampleGroups::LibTicTacToeRb::Play:0x007fdafb0dea20>).gets(*(any args))
           expected: at least 1 time with any arguments
           received: 0 times with any arguments
     # ./spec/02_play_spec.rb:10:in `block (3 levels) in <top (required)>'
```

The key output is the failed expectation.

```
Failure/Error: expect(self).to receive(:gets).at_least(:once).and_return("1")
  expected: at least 1 time with any arguments
  received: 0 times with any arguments
```

The test is saying that during the call to `#play`, we expected the program to call `gets`, but it didn't. Let's fix this simply by updating the definition of `#play`.

```ruby
def play(board)
  input = gets
end
```

```
./lib/tic_tac_toe.rb
  #play
    asks for players input on a turn of the game

Finished in 0.0058 seconds (files took 0.1434 seconds to load)
1 example, 0 failures
```

And it works! We don't want to just use that, the `#play` method is way more complicated and probably shouldn't be calling `gets` itself but rather having some other method, like `#turn` call gets. As long as something `#play` does meets the expectations set, the test will pass.

#### Watch out for hanging test Stack Level Too Deep

The test may just appear to freeze in the middle or you might run into this error:

```
SystemStackError:
       stack level too deep
     # ./lib/tic_tac_toe.rb:60:in `puts'
     # ./lib/tic_tac_toe.rb:60:in `turn'
     # ./lib/tic_tac_toe.rb:67:in `turn'
     # ./lib/tic_tac_toe.rb:67:in `turn'
     # ./lib/tic_tac_toe.rb:67:in `turn'
     # ./lib/tic_tac_toe.rb:67:in `turn'
     ...
     ..
     .
```

This means that we're calling a method that gets stuck in an infinite loop. A common location where this occurs is testing the `play` method without using the `over?` method to determine if the game is over. This is because our test stubs the `over?` method to manually return true even when the game isn't over. So if you are not basing your decision in your code to stop taking turns when the game is `over?` then we end up in an infinite loop!

### The CLI: `bin/tictactoe`

Your `bin/tictactoe` CLI should:

1. Greet the players with "Welcome to Tic Tac Toe!"
2. Define a `board` array.
3. Display the starting board.
4. Begin the game by calling `#play`.

#### Tip: Using a Console

When building a large application like this one, it's useful to be able to explore your code through an interactive console that has all your code loaded. For example, imagine wanting to test your `#valid_move?` method. You might have built the method in `lib/tic_tac_toe.rb`, but besides finishing the entire lab and trying it in the context of your CLI or running the test suite and seeing output, it's very hard to know how the method you built behaves. So you might start `irb` in your terminal and copy the source of your `#valid_move` method into a new IRB session so you can play with it. But as the methods become more complex and dependent, that breaks down. So we've given you a console that will load your code for you into a sort of interactive playground.

First, run `bundle` to make sure all your gems are installed. Then, you can start the console with `rake console` in your terminal.

Imagine your `lib/tic_tac_toe.rb` containing:

```ruby
def move(board, index, player = "X")
  board[index] = player
end
```

If you run `rake console`, you'll see.

```
$ rake console
Loading your application environment...
Console started:
[1] pry(main)>
```

At your prompt, you can execute ruby just like you could in an IRB session. The only difference is that your console has already read all the code in your application, so you have access to it in this Pry session.

```
$ rake console
Loading your application environment...
Console started:
[1] pry(main)> board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
=> [" ", " ", " ", " ", " ", " ", " ", " ", " "]
[2] pry(main)> valid_move?(board, 0)
=> true
[3] pry(main)> board = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
=> ["X", " ", " ", " ", " ", " ", " ", " ", " "]
[4] pry(main)> valid_move?(board, 0)
=> false
```

As you can see, it's easy to test the method with data we created.

## Play Your Game

Once you get all the tests to pass, play your game!

```
$ bin/tictactoe
```

Feel proud. You can't imagine how far we've come already.

## Code Coverage

Included with this lesson is a tool that will generate a Coverage Report that shows how much of our code is tested when we run our tests. After a test run, you can open the file generated in `coverage/index.html` from terminal with `open coverage/index.html` (**If you're using the Learn IDE, don't run the `open` command here. Instead run `httpserver` and then open the IP address noted in browser and select the link to `coverage/`**). It should pop up in your browser and look like:

![Coverage](https://dl.dropboxusercontent.com/s/59peed056jjk9xm/2015-09-20%20at%203.39%20PM.png)

When you click on `lib/tic_tac_toe.rb`, you'll see something like:

![Coverage 2](https://dl.dropboxusercontent.com/s/3xzof85jm0g5vwp/2015-09-20%20at%203.40%20PM.png)

The lines in green have been tested, the lines in red haven't. When all tests pass, you should see 100% test coverage.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/tic-tac-toe-rb' title='Tic Tac Toe in Ruby'>Tic Tac Toe in Ruby</a> on Learn.co and start learning to code for free.</p>
