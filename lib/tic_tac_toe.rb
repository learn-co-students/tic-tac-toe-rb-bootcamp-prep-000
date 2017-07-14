require 'pry'

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
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

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, position)
  board[position] == "X" || board[position] == "O" ? true : false
end

def valid_move?(board, position)
  !position_taken?(board, position) && position.between?(0, 9) ? true : false
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  if valid_move?(board, input_to_index(user_input))
    move(board, input_to_index(user_input), current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  occupied_positions = 0
  board.each do |index|
    if index == "X" || index == "O"
      occupied_positions += 1
    end
  end
  occupied_positions
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |winning_array|
    win_index_1 = winning_array[0]
    win_index_2 = winning_array[1]
    win_index_3 = winning_array[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return winning_array
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return winning_array
    end
  end
  return false
end

def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  won?(board) || full?(board) || draw?(board) ? true : false
end

def winner(board)
  if won?(board)
    winning_character = won?(board)[0]
    board[winning_character]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
