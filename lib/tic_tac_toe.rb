
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Mid row
  [6,7,8], # Btm row
  [0,3,6], # L columns
  [1,4,7], # M columns
  [2,5,8], # R columns
  [0,4,8], # R diagonal
  [6,4,2]  # L diagonal
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  index = (user_input.to_i)-1
  return index
end


def move(array, index, value)
  array[index] = value
end


def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  else
    return false
  end
end


def valid_move?(board, index)
  if (index >= 9 || index < 0 || index == !Fixnum)
    puts "Not a valid move. Try again."
    return false
  elsif position_taken?(board, index)
    puts "Position taken. Try again."
    return false
  else
    return true
  end
end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
     player = current_player(board)
     move(board, index, player)
     display_board(board)
   else
     turn(board)
   end
end


def turn_count(board)
  count = 0
  board.each do |board|
    if board == "X" || board == "O"
    count += 1
    end
  end
  return count
end


def current_player(board)
  if turn_count(board) % 2 == 0
    player = "X"
  else
    player = "O"
  end
return player
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    index_1 = win_combo[0]
    index_2 = win_combo[1]
    index_3 = win_combo[2]

    pos_1 = board[index_1]
    pos_2 = board[index_2]
    pos_3 = board[index_3]

    if (pos_1 == "X" && pos_2 == "X" && pos_3 == "X") || (pos_1 == "O" && pos_2 == "O" && pos_3 == "O")
      return win_combo
    end

  end
  return false
end

def full?(board)
  board.each do |i|
    if i == " "
      return false
    end
  end
    return true
end

def draw?(board)
  if won?(board) != false
    return false
  end
  return full?(board)
end

def over?(board)
  if won?(board) != false
    return true
  end
return draw?(board)
end

def winner(board)
  win_combo = won?(board)
  if won?(board)
    return board[win_combo[0]]
  end
return nil
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
