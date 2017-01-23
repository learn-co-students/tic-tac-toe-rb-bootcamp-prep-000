require 'pry'

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left Column
  [1,4,7],  # Middle Column
  [2,5,8],  # Right Column
  [0,4,8],  # Diagnoal L to R
  [2,4,6]  # Diagnoal R to L
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

def move (board, position, player)
  board[position] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move? (board, index)
  if index.between?(0, 8)
    if position_taken?(board, index) == false
      true
    else position_taken?(board, index) == true
      false
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  gets_index = gets.strip
  index = input_to_index(gets_index)
    if valid_move?(board, index)
      move(board, index, current_player(board))
    else
      turn(board)
    end
  display_board(board)
end

def turn_count(board)
  counts = 0
  board.each do |i|
    if i == "X" || i == "O"
      counts += 1
    end
  end
  counts
end

def current_player(board)
  if turn_count(board).odd?
    "O"
  else
    "X"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win|
    board[win[0]] == board[win[2]] && board[win[1]] == board[win[2]] && position_taken?(board, win[0])
  end
end

def full?(board)
  unless board.any? { |i| i == " " }
    true
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board)  ||  full?(board) || won?(board)
end

def winner(board)
  if winning_array = won?(board)
    board[winning_array[0]]
  end
end

def play(board)
  9.times do
    if !over?(board)
      turn(board)
    elsif draw?(board)
      puts "Cats Game!"
      break
    elsif won?(board)
      puts "Congratulations #{winner(board)}!"
      break
    end
  end
end
