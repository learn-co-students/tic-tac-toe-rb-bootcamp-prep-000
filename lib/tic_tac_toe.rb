WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left Column
  [1,4,7],  # Middle Column
  [2,5,8],  # Right Column
  [0,4,8],  # Left to right
  [2,4,6]   # Right to left
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

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

def turn_count( board )
  counter = 0
  board.each { |player| counter += 1 if player == "X" || player == "O" }
  return counter
end

def current_player( board )
  turn_count( board ) %  2 == 0 ? "X" : "O"
end

def won?( board )
  WIN_COMBINATIONS.detect{|win_combination| board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] && position_taken?( board, win_combination[0] )}
end

def full? ( board )
  board.all?{|element| element == "X" || element == "O"}
end

def draw? ( board )
  full?( board ) && !won?( board )
end

def over? ( board )
  won?(board) || draw?(board) || full?(board)
end

def winner ( board )
  if win_combination = won?(board)
    board[win_combination[0]]
  end
end

def play( board )
  counter = 0
  
  while counter < 9
    break if over?(board)
    turn(board)
    counter += 1
  end
  
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cat's Game!" if draw?(board)
end