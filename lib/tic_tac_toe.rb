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


def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (input)
  input.to_i - 1
end

def valid_move? (board, index)
  if (!index.between?(0, 8))
    return false
  elsif (position_taken?(board, index))
    return false
  else
    return true
  end
end

def position_taken? (board, index)
  if (board[index] == " ")
    return false
  elsif (board[index] == "")
    return false
  elsif (board[index] == nil)
    return false
  else
    return true
  end
end

def move (board, index, token)
  board[index] = token
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  token = current_player(board)
  if (valid_move?(board, index))
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |element|
    if (element == "X" || element == "O")
      count += 1
    end
  end
  return count
end

def current_player(board)
  turns = turn_count(board)
  return turns.even? ? "X" : "O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won? (board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return [win_index_1, win_index_2, win_index_3]
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return [win_index_1, win_index_2, win_index_3]
    end
  end
  return false
end

def full? (board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw? (board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end

def over? (board)
  won?(board) || full?(board) || draw?(board)
end

def winner (board)
  result = won?(board)
  if !result
    return nil;
  end
  win_index_1 = result[0]
  return board[win_index_1]
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