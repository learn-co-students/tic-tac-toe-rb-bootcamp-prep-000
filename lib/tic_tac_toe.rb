

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  counter = 0
  board.each do |board|
    if board == "X" || board == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ?  "X" : "O"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  if board == [" "," "," "," "," "," "," "," "," "]
    return false
  end
  WIN_COMBINATIONS.select do |win_combo|
    index_1 = win_combo[0]
    index_2 = win_combo[1]
    index_3 = win_combo[2]

    position_1 = board[index_1]
    position_2 = board[index_2]
    position_3 = board[index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
      (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combo
    else
      false
    end
  end
  return false
end

def full?(board)
  board.none? {|i| i == " "}
end

def draw?(board)
  won?(board) == false && full?(board) == true ? true : false
end

def over?(board)
  if draw?(board) == true
    return true
  elsif won?(board) != false && full?(board) == true
    return true
  elsif won?(board) != false && full?(board) == false
    return true
  else
    false
  end
end

def winner(board)
  WIN_COMBINATIONS.select do |win_combo|
    index_1 = win_combo[0]
    index_2 = win_combo[1]
    index_3 = win_combo[2]

    position_1 = board[index_1]
    position_2 = board[index_2]
    position_3 = board[index_3]

if (position_1 == "X" && position_2 == "X" && position_3 == "X")
  return "X"
elsif   (position_1 == "O" && position_2 == "O" && position_3 == "O")
  return "O"
else
  false
end
end
return nil
end


def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) != false
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    end
  end
if draw?(board) == true
  puts "Cat's Game!"
end
end
