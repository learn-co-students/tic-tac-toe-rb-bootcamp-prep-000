# Helper Method
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

def play(board)
  while !over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

def turn(board)
  puts "Please enter a number (1-9):"
  new_move = input_to_index(gets.strip)
  while !valid_move?(board, new_move)
    puts "Please enter a number (1-9):"
    new_move = input_to_index(gets.strip)
  end

  board = move(board, new_move,
    current_player(board))
  display_board(board)
end

def input_to_index(input)
  input.strip.to_i - 1
end

def display_board(arr)
  puts " #{arr[0]} | #{arr[1]} | #{arr[2]} "
  puts "-----------"
  puts " #{arr[3]} | #{arr[4]} | #{arr[5]} "
  puts "-----------"
  puts " #{arr[6]} | #{arr[7]} | #{arr[8]} "
end

def valid_move?(board, index)
  index.between?(0, 8) && (board[index] =~ /\S+/).nil?
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def move(board, index, token)
  board[index] = token
end

def turn_count(board)
  filled_board = board.select { |x| !(x.strip == "") }
  filled_board.count
end

def current_player(board)
  curr_turn_count = turn_count(board)
  return "X" if curr_turn_count % 2 == 0
  return "O" if curr_turn_count % 2 == 1
  return nil
end

def won?(board)
  winning_combo = []
  WIN_COMBINATIONS.each do |idxs|
    if idxs.all? { |x| board[x] == "X" }
      winning_combo = idxs
    elsif idxs.all? { |x| board[x] == "O" }
      winning_combo = idxs
    end
  end

  if winning_combo == []
    return nil
  else
    return winning_combo
  end
end

def over?(board)
  full?(board) || !(won?(board).nil?)
end

def draw?(board)
  full?(board) && won?(board).nil?
end

def full?(board)
  filled_either = board.select { |i| i == "X" || i == "O" }
  filled_either.length == 9
end

def winner(board)
  winning_combo = won?(board)
  return nil if winning_combo.nil?
  return board[winning_combo[0]]
end
