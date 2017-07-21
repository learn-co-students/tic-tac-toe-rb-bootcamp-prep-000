

#display_board
def display_board(board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

#input_to_index
def input_to_index(user_input)
  user_input.to_i - 1
end

#move
def move(board, index, character)
  board[index] = character
end

#position_taken
def position_taken?(board, index)
  if board[index] == " "
    false
  elsif board[index] == ""
    false
  elsif board[index] == nil
    false
  else
    true
  end
end

#valid_move
def valid_move?(board, index)
  if position_taken?(board, index) == false && index <= 8 && index >= 0
     true
  else
     false
   end
end

#turn
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) == false
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
  else
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  end
end

#turn_count
def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1
    else
      counter += 0
    end
  end
    counter
end

#current_player
def current_player(board)
  if turn_count(board)%2 == 0
    "X"
  else
    "O"
  end
end

#WIN_COMBINATIONS
WIN_COMBINATIONS = [
  [0,1,2], # Top rows
  [3,4,5], # Middle rows
  [6,7,8], # Bottom row
  [0,4,8], # left diagonal
  [2,4,6], # right diagonal
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8] # right column
]

#won?
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
  end
end

#full?
def full?(board)
  if board.detect{|index| index == "" || index == " "}
    false
  else
    true
  end
end

#draw?
def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

#over?
def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

#winner
def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
  end
end

#play
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end
