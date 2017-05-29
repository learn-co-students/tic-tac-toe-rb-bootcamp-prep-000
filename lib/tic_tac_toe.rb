# all posible win combinations
WIN_COMBINATIONS =[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

# displays the tic tac toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Takes the user's input and turns it into an index
def input_to_index(user_input)
  return user_input.to_i - 1
end

# updates the board array with the new index from the above method.
def update_array_at_with(array, index, value)
  array[index]=value
  return array
end

# takes the array update from above and turns it into a move on the tic tac toe board
def move(board, index, char)
  update_array_at_with(board, index, char)
end

# checks to see if a given position is taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Checks that the move entered is a valid move, by checking that the position is not taken and that the number of
def valid_move?(board, index)
  if position_taken?(board,index) || index < 0 || index > 8
    return false
  elsif !position_taken?(board, index)
    return true
  end
end

# Displays the text for any given turn, checks to make sure the value give is a valid move, and then updates the board accordingly
def turn(board)
  user_input = gets.strip
  index=input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, char= current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


# simulates one turn of the game. Will, by the end of the lab, be the focal method that runs the game
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "you did it"
  elsif draw?(board)
    puts "niether of you did it"
  end
end

# counts how many turns it has been
def turn_count(board)
  turns = 0
  board.each do |counter|
    if counter == "X" || counter == "O"
      turns += 1
    end
  end
  return turns
end

# tracks who's turn it is by keeping track of how many turns have passed
def current_player(board)
  if turn_count(board)%2 == 0
    return "X"
  else
    return "O"
  end
end

# Compares all the win combos against the board and the positions taken. If the positions that equal a win have been taken, and positions 1,2,3 of that combo array are all the same, then there is a win condition met.
def won?(board)
  WIN_COMBINATIONS.find do |combo|
    # original argument "position_taken?(board, combo)"
    position_taken?(board, combo[0]) &&
    board[combo[0]] == board[combo[1]] &&
    board[combo[0]] == board[combo[2]]
  end
end

# checks to see if the board is full by checking that there are no empty spaces
def full?(board)
  board.all? do |index|
    index != " "
  end
end

# checks to see if the board has ended in  a draw, or that the board is full, but no one has won.
def draw?(board)
  full?(board)
  !(won?(board))
end

# checks to see if the game is over either by a draw or someone won
def over?(board)
  draw?(board) || won?(board)
  full?(board)
end

# Declares the winner of the game by using the return value of the over? method as an index value on the board. If the won? == true, then it will return the win combo from over? as an index value for the board. It will then return that index's value.
def winner(board)
  if won?(board)
   return board[won?(board)[0]]
  end
end
