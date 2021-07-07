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

def move(board, index, character)
   board[index] = character
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  end
  if board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
  spot = index.to_i
  if position_taken?(board, spot) == false && spot.between?(0, 8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  num = gets.strip
  index = input_to_index(num)
  if valid_move?(board, index) == true
    character = current_player(board)
    move(board, index, character)
    return display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
   board.each do |space|
     if space == "X" || space == "O"
       turns += 1
     end
   end
   return turns
 end

 def current_player(board)
   if turn_count(board).even? == true
     return "X"
   else
     return "O"
   end
 end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    position_taken?(board, win_combo[0]) && board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]]
  end
end

def full?(board)
  if board.all? {|i| i == "X" || i == "O"}
    return true
  else
    return false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board)
    return false
  else !full?(board)
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
