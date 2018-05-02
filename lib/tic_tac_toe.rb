board = [" "," "," "," "," "," "," "," "," "]

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
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player_character)
  board[index] = player_character
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  !position_taken?(board, index) && (index >= 0 && index <= 9)
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = win_combination[0]
    position_2 = win_combination[1]
    position_3 = win_combination[2]
    if board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X"
      return win_combination
    elsif board[position_1] == "O" && board[position_2] == "O" && board[position_3] == "O"
      return win_combination
    end
  end

  empty_board = board.any? { |position| position == "X" || position == "O" }
  if empty_board
    return false
  end
end

def full?(board)
  board.all?{ |position| position == "X" || position == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winning_combo = won?(board)
  if won?(board)
    return board[winning_combo[0]]
  else
    nil
  end
end
