# Define your WIN_COMBINATIONS constant
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

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
    puts " #{board[0]} ""|"" #{board[1]} ""|"" #{board[2]} "
    puts "-----------"
    puts " #{board[3]} ""|"" #{board[4]} ""|"" #{board[5]} "
    puts "-----------"
    puts " #{board[6]} ""|"" #{board[7]} ""|"" #{board[8]} "
end

# converts a user input to an integer
def input_to_index(user_input)
  user_input.to_i - 1
end
# move
def move(board, index, current_player)
  board[index] = current_player
end
# returns true/false based on position in board
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
# returns true/false based on position
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
# makes valid moves, asks for input again after failed validation
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
# counts occupied positions
def turn_count(board)
  count = 0
  board.each do |element|
    if element == "X" || element == "O"
       count += 1
    end
  end
  count
end
# returns current player
def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 0
    "X"
  else
    "O"
  end
end
# returns false for a draw, true for a win
def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        win_combination # return the win_combination indexes that won.
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        win_combination # return the win_combination indexes that won.
      else
        false
      end
  end
end
# returns true for a draw, false for game in progress
def full?(board)
  if board.detect {|i| i == " " || i == nil}
    false
  else
    true
  end
end
# calls won? and full?. returns true for a fraw
def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end
# true for a draw, true for a won game, false for game in progress
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  end
end
# return X when X won, O when O won, nil for no winner
def winner(board)
  if win_combination = won?(board)
     board[win_combination.first]
  end
end
# play method
def play(board)
  until over?(board)
     current_player(board)
     turn(board)
   end
   if won?(board)
     puts "Congratulations #{winner(board)}!"
   else
     puts "Cats Game!"
   end
end
