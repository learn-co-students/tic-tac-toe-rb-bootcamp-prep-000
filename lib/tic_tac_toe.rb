WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
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

def player_move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  ["X", "O"].include?(board[location])
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player_move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  counter = 0
  board.each do |pos|
    count += 1 if position_taken?(board, counter)
    counter += 1
  end
  count
end

def current_player(board)
  ["X", "O"][turn_count(board) % 2]
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]]
    && board[combo[1]] = board[combo[2]]
    && position_taken(board[combo[0]])
  end
end

def full?(board)
  board.all?{|val| ["X", "O"].include?(val)}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  combo = won?(board)
  if combo
    return board[combo[0]]
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
