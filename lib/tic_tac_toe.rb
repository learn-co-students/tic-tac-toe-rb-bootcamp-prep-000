#All Possible Win Combos
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

#GAME LOGIC

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " "
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter a number 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

#GAME STATUS
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]
    
    pos1 = board[win_index_1]
    pos2 = board[win_index_2]
    pos3 = board[win_index_3]
    
    if pos1 == "X" && pos2 == "X" && pos3 == "X"
      return win_combo
    elsif pos1 == "O" && pos2 == "O" && pos3 == "O"
      return win_combo
    else
      false
    end
  end
  return false
end


def full?(board)
  !board.any?{|pos| pos == " " || pos == ""}
end

def draw?(board)
  fullCheck = full?(board)
  if !won?(board) && fullCheck
    return true
  elsif !won?(board) && !fullCheck
    return false
  end
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    if board[won?(board)[0]]== "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end