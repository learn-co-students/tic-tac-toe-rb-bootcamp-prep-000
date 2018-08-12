require 'pry'

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
  user_input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  !board[position].strip.empty?
end

def valid_move?(board, position)
  position.between?(0, 8) && !position_taken?(board, position)
end

def turn(board)
  puts 'What is your move position (1-9)'
  
  position = input_to_index(gets.strip)

  if valid_move? board, position
    board[position] = current_player(board)
    display_board(board)
  else
    puts 'That space is taken. Please try again.'
    turn(board)
  end
end

def turn_count(board)
  board.count { |letter| letter == 'X' || letter == 'O' }
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.detect do |winning_combo|
    board[winning_combo[0]] != ' ' &&
    board[winning_combo[0]] == board[winning_combo[1]] &&
    board[winning_combo[1]] == board[winning_combo[2]]
  end
end

def full?(board)
  board.all? { |element| element == 'X' || element == 'O'}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board) ? board[won?(board).first] : nil
end

def play(board)
  # puts "Welcome to Tic Tac Toe!"
  
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end