WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  [0, 3, 6], # left column
  [1, 4, 7], # middle column
  [2, 5, 8], # right column
  [0, 4, 8], # top left diagonal
  [6, 4, 2]  # bottom left diagonal
].freeze

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, position)
  !board[position].nil? && board[position] != ' '
end

def valid_move?(board, position)
  true if position.between?(0, 8) && !position_taken?(board, position)
end

def turn(board)
  puts 'Please enter 1-9:'
  user_input = input_to_index(gets.strip)
  if valid_move?(board, user_input)
    move(board, user_input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == 'X' || turn == 'O'
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    board[combo[0]] == board[combo[1]] &&
      board[combo[1]] == board[combo[2]] &&
      position_taken?(board, combo[0])
  end
end

def full?(board)
  board.none? { |spot| spot == ' ' }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  winner = won?(board)
  board[winner.first] if winner
end

def play(board)
  until over?(board)
  turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end
