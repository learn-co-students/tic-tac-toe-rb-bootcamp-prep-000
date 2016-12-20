# Define your WIN_COMBINATIONS constant (note: constants start with capital letters)
WIN_COMBINATIONS = [
  [0,1,2], # Top row across
  [3,4,5], # Middle row across
  [6,7,8], # Bottom row across
  [0,3,6], # left row down
  [1,4,7], # center row down
  [2,5,8], # right row down
  [0,4,8], # diagonal left to right corner
  [2,4,6], # diagonal right to left corner
]

# Helper methods
def display_board(board)
  rows = [" #{board[0]} | #{board[1]} | #{board[2] } ", "-----------", " #{board[3]} | #{board[4]} | #{board[5] } ", "-----------", " #{board[6]} | #{board[7]} | #{board[8] } "]
  puts rows
  puts board
end

def input_to_index(user_input) #this method converts the user_input into the 0-8 index, AKA the position on the board
  user_input = user_input.to_i # assign user_input to (user_input.to_i), which converts the user_input to an integer
  user_input = user_input-1 # assign user_input to (user_input-1), which substracts 1 from the user_input
  #the above line with the (user_input-1) also returns -1 for strings without integers
end

def move(board, index, token) # "X" is the default value for the token parameter --- we don't want a default value here
  board[index].replace(token) # replace board[index] (the position on the board) with the token
end #end of method

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if (index > 9) || (index < 0) #if index (position on board entered by user) is greater than 9 or less than 0, return false
    false
  elsif position_taken?(board, index) #otherwise, if position on board is taken, return false
    false
  else index.between?(0, 8) #finally, if the position isn't taken, and the index (position on board entered by user) is between 0 and 8, return true
    true
  end # end if...elsif statements
end # end valid_move? method

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, ("X" || "O") ) ######("X") || ("O") ) # <<<<<<-------------- "X" || "O" here.....    note this other stuff:::: ///// #current_player here ////// token="X" here, but not in #move(board, index, token)
    display_board(board)
  else
    turn(board)
  end # end if..else statement
end # end method

# def turn(board)
#   puts "Please enter 1-9:" # add to this, invoke other methods within #turn
#   user_input = gets # gets move from user
#   index = input_to_index(user_input) ### <<<---- calls the input_to_index method, to convert the user_input into the 0-8 index, and assigns value of input_to_index(user_input) to local variable 'index'
#   if valid_move?(board, index) == true
#     # if valid_move? returns true, meaning we've validated the move...
#     move(board, index, token) #...then we run the move method
#     display_board(board) #...and display the board
#   else turn(board) # if the user's move wasn't valid, we return this function again, from within the function
#   end # end if...else statement
# end # end turn method



def turn_count(board)
  counter = 0 #counter is set to 0 before the for each loop interation begins
  board.each do |turn_count| # the variable turn_count can be called anything, this is a new local variable
    #puts "Loop number #{counter} gets tuuurn: #{turn_count}"
    if (turn_count == "X") || (turn_count == "O") # this if statement is within the loop iteration
      #puts "Loop number #{counter} gets turn: #{turn_count}"
      #puts turn_count # i'm outputing the turn_count to see it, but the 'return counter' below is what passes the test
      counter += 1 #adding 1 to the counter for each "X" and "O" in the board array
    end #end if statement
  end #end for...each loop iteration
  return counter # the counter holds the number of turns, and is what passes the test
end #end method

def current_player(board)
  if (turn_count(board) % 2 == 0) # if the value of turn_count(board) is divisible by 2, and therefore is even...
    puts "X" # output "X" -- i'm doing this so i can see the output
    return "X" # return "X"
  elsif (turn_count(board) % 2 == 1) # elsif the value of turn_count(board) is odd...
    puts "O" # output "O" -- i'm doing this so i can see the output
    return "O" # return "O"
  end # end if...else
end # end method

def won?(board)
#for each win_combination in WIN_COMBINATIONS
WIN_COMBINATIONS.find do |win_combination| # find instead of each??
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.

  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      puts win_combination # output win_combination so i can see what the hell is happening
      true # not 'return true', just 'true' -- find method looks for what evaluates to true and returns the element that caused the true evaluation
    else
      false # not 'return false', just 'false' -- see above note for 'true'
    end # end if...else statement
  end # end for-each-loop... AKA WIN_COMBINATIONS.each do |win_combination|
end # end method



def full?(board)  ###### this method works, but this can be written more clearly <<<----
  board.all? do |positions|
    #puts "The #{board.length} position is #{positions}"

  if positions == " "
    puts "The board is NOT full, there are some empty spaces."
  #if board.all? { |obj| obj }
    false
  elsif (positions == "X") || (positions == "O")
  #elsif board.all?
    puts "The board is full!"
    true
    end # end if...else statement
  end # end for each loop
end # end full? method

#####another way to do it, much simpler... this is how a Learn.co instructor said it could be done:
# def full?(board)
#   board.all?{|token| token == "X" || token == "O"}
# end



def draw?(board)
  if !won?(board) && !full?(board) # if not won and board is not full
    puts "The board is not full yet, so it can't be a draw."
    false # it is NOT a draw
  elsif !won?(board) && full?(board) # if not won and full board
    puts "The game is a draw. No one wins."
    true # it is a draw
  end # end if statement
end # end method


def over?(board)
  if draw?(board)
    puts "Cats Game!"
    true
  elsif won?(board)
    winner(board) # call winner(board) method to congratulate X or O
    true
  else
    puts "The game is not over yet."
    false
  end # end if...elsif..else statement
end # end method



##another way to do winner(board), by copying won?(board):::
#def winner(board) # same as won?(board) method #### <<<<-------- better way to do this???

def winner(board)
  if won?board
    if board[won?(board)[0]] == "X"
      puts "Congratulations X!"
      return "X"
    elsif board[won?(board)[0]] == "O"
      puts "Congratulations O!"
      return "O"
    end # end if..else statement
  else !won?(board)
    nil ###this nil is returned outside the if..elsif statement, which is inside the if won?board statement
  end # end if won?board statement
end # end method

####### super small version::::::::
# def winner(board)
#   if won?(board)
#     puts "#{board[won?(board)[0]]} is the winner"
#     return board[won?(board)[0]]
#   end
# end



#with until loop:::
def play(board) #play method initiates a simple loop and calls #turn
  until over?(board)
    turn(board) #calls turn method
  end #end until over?(board) loop
end #end play(board) method



# def play(board)
#   # turn(board)
#   # if over?(board) ###== true
#   #   # if the game is over after that last move...
#   #   over?(board) #...then run the over?(board) method, to do whatever happens if the game is over (win, lose, or draw)
#   # end #end if over?(board) statement
# end #end method
