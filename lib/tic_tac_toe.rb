WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Left to Right
  [2,4,6]  # Right to Left
]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} ""|"" #{board[1]} ""|"" #{board[2]} "
  puts "-----------"
  puts " #{board[3]} ""|"" #{board[4]} ""|"" #{board[5]} "
  puts "-----------"
  puts " #{board[6]} ""|"" #{board[7]} ""|"" #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == ""
    taken = false
  elsif board[index] == "X" || board[index] == "O"
    taken = true
  else
    taken = false
  end
  taken
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    valid = true
  else
    valid = false
  end
  valid
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  display_board(board)
  if valid_move?(board, index)
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_taken = 0
  board.each do |play|
    if play == "X" || play == "O"
      turn_taken += 1
    end
  end
 turn_taken
end

def current_player(board)
  if !turn_count(board).odd?
    player = "X"
  else
    player = "O"
  end
  player
end

def won?(board)
  WIN_COMBINATIONS.detect { |wins|
    win_index_1 = wins[0]
    win_index_2 = wins[1]
    win_index_3 = wins[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return wins
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return wins
  else
    false
  end
  }
end

def full?(board)
  if board.any? { |e| e == " " }
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  end
end

def over?(board)
  if won?(board)
    true
  elsif draw?(board)
    true
  elsif full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
