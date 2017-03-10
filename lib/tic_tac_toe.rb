# combinations of index that can win in tic tac toe
WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
]


def display_board(board)
  # whatever is placed into the array, the index of board will output the index into the space assigned.
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  #changes the input of 1 through 9 to 0 ythrough 8 to match array index
  input.to_i - 1
end
 # creates the move of the player and place the character in the chosen spot
def move(board, index, current_player)
  board[index] = current_player
end

# is the position taken?
def position_taken?(board, index)
  # if the spot on the board is empty,it is not taken
  if board[index] == "" || board[index] == " " || board[index] == nil
    false
    #if it hs an "X" or "O" then it is taken
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

def valid_move?(board, index)
# if the index is between 0 and 8 it is a vaild index
# if there is nothing in the place in the board make the first condition of 'position_taken?' true(other words the position is not taken)
 index.between?(0,8) && !position_taken?(board, index)

end

def turn(board)
  puts "Please enter 1-9:"
  #grab input
  input = gets.strip
  # use input_to_index method to change the inputted number to an index number

  index = input_to_index(input)

  # if the move is valid using the valid_move? method
  if valid_move?(board, index)
    #place the move in the board
    move(board, index, current_player(board))
    #display the board with the updated move
    display_board(board)
  else
    # if the input is not valid, ask to enter 1-9 again
      turn(board)
    end
end

def turn_count(board)
  #start counter at 0 for number of turns
  number_of_turns = 0
  #Iterate through the board and if there is a X or O add a turn
  board.each do |element|
    if element == "X" || element == "O"
    number_of_turns += 1
    end
  end
  #bring back number of turns
  number_of_turns
end

def current_player(board)
  #grab number of turns
  turn_count(board)
  #if number of count is even its X turn
  if turn_count(board).even?
    "X"
    # if not its is O turn
  else
    "O"
  end
end

  def won?(board)
  #iterates through "WIN_COMBINATIONS" and brings back the first elemnt that is true
WIN_COMBINATIONS.detect do |win_combination|
  #.detect brings back the elements for win_combination that match and if win_combination[0], [1] and [2]
  # and the position is taken.
        board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] &&
        #since 'win_combination[0]' is already matching the other 2 we only place the 1 argument to check the one index
        #to make sure the position isnt an empty string.
        position_taken?(board, win_combination[0])
    end
end

def full?(board)
  # if board does not include empty string the board is full
  !board.include?(" ")
end

def draw?(board)
  #if the board is not won, and the board is full, its a draw
!won?(board) && full?(board)
end

def over?(board)
  #If the board is won or the board is full, the game is over
  won?(board) || full?(board)
end

def winner(board)
  #assign variable winning_combo to won?(board)
  #if the board is won, call back the board and the winning_combo and return the first item from the winning_combo to show who won.
if  winning_combo = won?(board)
    board[winning_combo.first]
  else
    nil
end
end

def play(board)
  #until the game is over or a draw
  until over?(board) || draw?(board)
    #take turns, this method give the next person a turn
    turn(board)
  end
  #if someone won, put congrats message to the winner from winner method
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    #if the game is draw, puts cats game message
  elsif draw?(board)
    puts "Cats Game!"
  end
end
