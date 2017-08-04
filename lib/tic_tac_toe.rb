WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
  [0, 4, 8], [2, 4, 6] # Diagonals
].freeze

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    return combination if won_with_this(board, combination)
  end
  false
end

def won_with_this(board, spaces)
  symbols = [board[spaces[0]], board[spaces[1]], board[spaces[2]]]
  symbols.all? { |symbol| symbol == 'X' } ||
    symbols.all? { |symbol| symbol == 'O' }
end

def full?(board)
  board.all? { |space| %w(X O).include?(space) }
end

def draw?(board)
  if won?(board)
    return false
  else
    return full?(board)
  end
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    winning_symbol_position = won?(board)[0]
    return board[winning_symbol_position]
  end
  nil
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != ' ' && board[location] != ''
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn_count(board)
  board.select { |space| %w(X O).include?(space) }.length
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def turn(board)
  loop do
    puts 'Please enter 1-9:'
    input = gets.strip
    index = input_to_index(input)
    next unless valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
    break
  end
end

def play(board)
  turn(board) until over?(board)

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts 'Cats Game!'
  end
end
