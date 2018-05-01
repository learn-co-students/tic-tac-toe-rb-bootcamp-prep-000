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

def input_to_index(index)
  index_i = index.to_i - 1
  return index_i
end

def move(board, index, character)
  board[index] = character
  return board
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8)
    if position_taken?(board, index)
      return false
    else
      return true
    end
  else
    return nil
  end
end

def turn()
  puts "Please enter 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move(board, index)
    move(board, index, character="X")
    display_board(board)
  else
    turn()
  end
end

def turn_count()
end

def current_player()
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if ((board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") || (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O") )
      return combo
    end
  end
  return false;
end

def full? (board)
  index = 0
  board.each do |cell|
    if !position_taken?(board, index)
      return false;
    end
    index += 1
  end
  return true
end

def draw?(board)
  if won?(board) == false && full?(board)
    return true
  elsif won?(board) == false && !full?(board)
    return false
  elsif won?(board) != false
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if !draw?(board) && over?(board)
    comboArray = won?(board)
    if board[comboArray[0]] == "X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end
end