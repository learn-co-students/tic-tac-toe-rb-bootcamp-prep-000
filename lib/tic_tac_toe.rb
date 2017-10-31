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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, player)
  board[index] = player
  return board
  display_board(board)
end

def position_taken? (board,index)
  if (board[index] == " " or board[index] == "" or board[index] == nil)
    return false
  else
    return true
  end
end

def valid_move? (board,index)
  if (index.between?(0,8) && !position_taken?(board,index))
    return true
  else
    return false
  end
end

def turn(board)
  loop do
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index (input)
    if (valid_move?(board,index))
      move(board,index,current_player(board))
      display_board(board)
      break
    end
  end
end

def turn_count(board)
  counter = 0
  board.each do |board|
    if (board == "X" or board == "O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def won? (board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      true
      return win_combination
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      true
      return win_combination
    else
    end
  end
return false
end

def full? (board)
  board.each do |place|
    if place == " " or place == ""
      return false
    end
  end
  return true
end

def draw? (board)
  if won?(board) == false && full?(board) == true
    return true
  end
  return false
end

def over? (board)
  if won?(board)
    return true
  end
  if draw?(board)
    return true
  elsif full?(board)
    return true
  else
    return false
  end
end

def winner (board)
  if won?(board) == false
    return nil
  else
    win_board = won?(board)
    return board[win_board[0]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) == false
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
