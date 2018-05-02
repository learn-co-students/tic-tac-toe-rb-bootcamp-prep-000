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

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  character = current_player(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
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
  count = turn_count(board)
  if count.even?
    "X"
  else
    "O"
  end
end

# Define your play method below


WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def winning_combos(board)
  WIN_COMBINATIONS.select do |winning_combo|
    (board[winning_combo[0]] == "X" && board[winning_combo[1]] == "X" && board[winning_combo[2]] == "X") || (board[winning_combo[0]] == "O" && board[winning_combo[1]] == "O" && board[winning_combo[2]] == "O")
  end
end

def won?(board)
  winning_combos(board).first
end

def full?(board)
  !board.any? do |board_position|
   board_position == " "
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
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
