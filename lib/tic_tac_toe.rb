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
  puts "  #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts "  #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts "  #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, mark) 
  if !position_taken?(board, index)
    board[index] = mark
  end
  board
end

def position_taken?(board, pos_idx)
  if board[pos_idx] == " " || board[pos_idx] == "" || board[pos_idx] == nil
    return false
  elsif board[pos_idx] == "X" || board[pos_idx] == "O" 
    return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) || !index.between?(0, 8)
    return false
  else 
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  mark = current_player(board)
  if valid_move?(board, index)
    move(board, index, mark)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0 
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1 
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X"
      return win_combo
    elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
      return win_combo
    end
  end
  return false
end

def full?(board)
  board.all? do |spot|
    (spot.include?("X") || spot.include?("O")) && board.count == 9
  end
end

def draw?(board)
  if won?(board)
    return false 
  end
  WIN_COMBINATIONS.each do |win_combo|
    if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X") || !full?(board)
      return false
    elsif (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O") || !full?(board)
      return false
    end
  end
  return true
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combo|
    if board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X"
      return "X"
    elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
      return "O"
    end
  end
  return nil
end

def play(board)
# until the game is over
# take turns
# end

# if the game was won
#   congratulate the winner
# else if the game was a draw
#   tell the players it has been a draw
# end

  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end

  
end 