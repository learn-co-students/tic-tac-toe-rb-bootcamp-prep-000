# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # top row win
  [3,4,5], # middle row win
  [6,7,8], # bottom row win
  [0,3,6], # left column win
  [1,4,7], # middle column win
  [2,5,8], # right column win
  [0,4,8], # left diagonal win
  [2,4,6], # right diagonal win
]

def display_board(board)
separator = "|"
lines = "-----------"

puts " #{board[0]} #{separator} #{board[1]} #{separator} #{board[2]} "
puts "#{lines}"
puts " #{board[3]} #{separator} #{board[4]} #{separator} #{board[5]} "
puts "#{lines}"
puts " #{board[6]} #{separator} #{board[7]} #{separator} #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
 converted_input = user_input.to_i
 converted_input = converted_input - 1
end

def move( board, index, character)
  board[index]= character
  return board
end

def position_taken?(board, index)
  ! (board[index] ==  " " || board[index] == "" || board[index] == nil)
  end

  # code your #valid_move? method here
def valid_move?(board, index)
(board[index] ==  " " || board[index] == "" || board[index] == nil) && index.between?(0,8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
  else
    turn
  end
  display_board
end

def turn_count(turn)

  move_count = []
  turn.each do |unit|
    if unit == "X" || unit == "O"
      move_count.push(1)
    end
  end
  move_count.length.to_i
end

def current_player(board)
    num = turn_count(board)
    if num % 2 == 0
      return "X"
    else
      return "O"
    end
end

def won?(board)
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
end
end

  def winner (board)
  index = []
  index = won?(board)
  if index == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end


# Define your play method below
def play
  until over? == true
    turn
  end

   if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end
end

 end
