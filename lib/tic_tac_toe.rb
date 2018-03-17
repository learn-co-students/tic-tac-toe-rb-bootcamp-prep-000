require 'pry'
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
]

def won?(board)
    WIN_COMBINATIONS.detect do |array|
       board[array[0]] == board[array[1]] && board[array[2]] == "X" && board[array[0]] == board[array[2]] ||
       board[array[0]] == board[array[1]] && board[array[2]] == "O" && board[array[0]] == board[array[2]]

    end
end

def full?(board)
  board.all? { |element| element == "X" || element == "O" }
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else return false
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  array = won?(board)
  if array == nil
    nil
  elsif board[array[0]] == "X"
    "X"
  else
    "O"
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
       counter += 1
    else
       counter += 0
    end
  end
  return counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else return "O"
end
end

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

def position_taken?(board, location)
  board[location] != " " && board[location] != "" && board[location] != nil
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

# def play(board)
#   turn(board)
#   if over?(board) == false
#     play(board)
#   elsif winner?(board) == "X"
#     puts "Congratulations X"
#   elsif winner?(board) == "O"
#     puts "Congratulations O"
#   else draw?(board) == true
#     puts "Cat's Game!"
#   end
# end

def play(board)

  while !over?(board)
    turn(board)
  end
  if won?(board) && winner(board) == "X"
    puts "Congratulations X!"
  elsif won?(board) && winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
end
