require 'pry'
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left columns
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #diagonal 1
  [6,4,2], #diagonal 2
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

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  if position_taken?(board, position) == false && position.between?(0, 8)

    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  position = input_to_index(user_input)
  token = current_player(board)
  if valid_move?(board, position) == true
    move(board, position, token)
    display_board(board)
    binding.pry

  else
    turn(board)
  end
end

def turn_count(board)
  board.count do |x|
    x == "X" || x == "O"
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
    token = "X"
  else
    token = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.any? do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
  end
end

def full?(board)
  board.all? do |position|
    if position == "X" || position == "O"
      true
    else
      false
    end
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  if won?(board) == true || draw?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    winning_combination = won?(board)
    return board[winning_combination[0]]
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats game!"
  end
end
