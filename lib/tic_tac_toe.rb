# first coding helper methods
#constant of all 8 possible winning combinations in nested array
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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  #user index is one less than input as index starts at 0
  user_input.to_i - 1
end

def move(board, index, current_player)
  # character being placed at a position on the board during move
  board[index] = current_player
end

def position_taken?(board, index)
  # as long as it is not any of these- if any of these are true it isn't truthy
   !(board[index] == " " || board[index] == "" || board[index].nil?)
end

def valid_move?(board, index)
  #condition for valid move- needs to be space on board that's not taken
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "What's your move between position 1-9 ?"
  user_input = gets.strip
  index = input_to_index(user_input)
  #if it's valid the current players character will be placed in the empty spot and will als be displayed
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  #iterating through each spot on board and counting presence of players characters
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
  board[combo[0]] == board[combo[1]] &&
  board[combo[1]] == board[combo[2]] &&
  position_taken?(board, combo[0])
  end
end

def full?(board)
  #going through every element on board to make sure spaces are full
  board.all?{ |space| space == "X" || space == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)

  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)

  until over?(board)
    turn(board)
  end

    if draw?(board)
      puts "Cats Game!"
    else
      puts "Congratulations #{winner(board)}!"
    end
end
