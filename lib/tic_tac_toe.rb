WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_cnt = 0
  board.each do |value|
    if value.strip == "X" || value.strip == "O"
      turn_cnt += 1
    end
  end
  turn_cnt
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_condition|
    if ((board[win_condition[0]] == "X" && board[win_condition[1]] == "X" && board[win_condition[2]] == "X") ||
        (board[win_condition[0]] == "O" && board[win_condition[1]] == "O" && board[win_condition[2]] == "O"))
        return win_condition
    end
  end
  return false
end

def full?(board)
  board.each do |value|
    if value != "X" && value != "O"
      return false
    end
  end
  return true
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  if (won?(board) || draw?(board) || full?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if(win_cond = won?(board))
    return board[win_cond[0]]
  end
    return nil
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
