WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
].freeze

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == '' || board[index] == ' ' || board[index].nil?
    false
  else
    true
  end
end

def valid_move?(board, index)
  true if position_taken?(board, index) == false && index.between?(0, 8)
end

def turn(board)
  puts 'Please enter 1-9:'
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)

  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    counter += 1 if turn == 'X' || turn == 'O'
  end
  counter
end

def current_player(board)
  counter = turn_count(board)

  counter.even? ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.select do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == 'X' && position_2 == 'X' && position_3 == 'X'
      return win_combination
    elsif position_1 == 'O' && position_2 == 'O' && position_3 == 'O'
      return win_combination
    end
  end
  false
end

def full?(board)
  board.none? { |i| i == ' ' }
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  true if won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if winning = won?(board)
    board[winning[0]]
  end
end

def play(board)
  turn(board) until over?(board)

  if won?(board)
    winning = winner(board)
    puts "Congratulations #{winning}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
