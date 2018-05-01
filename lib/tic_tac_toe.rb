require 'pry'
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2],
  ]

  def display_board
    line = "   |   |   "
    dash = "-----------"
    puts line
    puts dash
    puts line
    puts dash
    puts line
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

def move(board, index, character)
  board[index] = character
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    return true
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == ""
    return false
  elsif board[index] == nil
    return false
  else
    return true
  end
end

def won?(board)
  winning_combinations(board).first
end

def winning_combinations(board)
    WIN_COMBINATIONS.select do |win_combo|

    (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X") ||  (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
end
end
def full?(board)
    !board.any? do |board_position|
      board_position == " "
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  character = current_player(board)
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |board_slot|
    if board_slot == "O" || board_slot == "X"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
   if turn_count(board).even?
     "X"
   else
     "O"
  end
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  winning_combination = won?(board)
  if winning_combination == nil
    return nil
  elsif board[winning_combination[0]] == "X"
  return "X"
else
  "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
