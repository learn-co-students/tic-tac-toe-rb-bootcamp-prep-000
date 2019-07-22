# WIN_COMBINATIONS = [
#     [0,1,2],
#     [3,4,5],
#     [6,7,8], 
#     [0,3,6],
#     [1,4,7],
#     [2,5,8],
#     [0,4,8],
#     [2,4,6]
#   ]
  
# def display_board(board)
#   puts " #{board[0]} | #{board[1]} | #{board[2]} "
#   puts "-----------"
#   puts " #{board[3]} | #{board[4]} | #{board[5]} "
#   puts "-----------"
#   puts " #{board[6]} | #{board[7]} | #{board[8]} "
# end

# def input_to_index(user_input)
#   user_input.to_i - 1
# end

# def move(board, index, current_player)
#   board[index] = current_player
# end

# def position_taken?(board, location)
#   board[location] != " " && board[location] != ""
# end

# def valid_move?(board, index)
#   index.between?(0,8) && !position_taken?(board, index)
# end

# def turn(board) 
#     puts "Please enter 1-9:"
#     user_input_turn = gets.strip
#     user_input_turn = input_to_index(user_input_turn)

#   if (valid_move?(board, user_input_turn))
#     move(board, user_input_turn, "X")
#     display_board(board)
#   else 
#     puts "Please enter 1-9:"
#     user_input_turn = gets.strip
#     user_input_turn = input_to_index(user_input_turn)
#     valid_move?(board, user_input_turn)
#     return move(board, user_input_turn, "X")
#   end
# end

# def turn_count(board)
#   count = 0
#   board.each do |play|
#     if (play == "X" || play == "O")
#       count += 1
#     end
#   end
#   return count
# end

# def current_player(board)
#   turn_count(board).odd? ? "O" : "X"
# end

# def won?(board)
#     WIN_COMBINATIONS.detect do | win_combo|
#       location1 = win_combo[0]
#       location2 = win_combo[1]
#       location3 = win_combo[2]
#       board[location1] == board[location2] && board[location2] == board[location3] && board[location1] != " "
#     end
# end
  
# def full?(board)
#     board.none? { | spaces | spaces == " "}
# end
  
# def draw?(board)
#     full?(board) && !won?(board)
# end
  
# def over?(board)
#     won?(board) || draw?(board) || full?(board)
# end

# def winner(board)
#     # board = ["X","X","X",""]
#     win_combination = won?(board) # => [0,1,2]
#     if win_combination != nil
#       winning_location = win_combination[0] # => X
#       board[winning_location]  # => X
#     else
#       return nil
#     end
# end

# def play(board)
#     until over?(board)
#       turn(board)
#     end
#     if winner(board) == "X"
#     puts "Congratulations X!"
#   else
#     puts "Congratulations O!"
#   end
#     if draw?(board)
#     puts "Cats Game!"
#       end
#     end

# def play(board)
#   while over? == false
#     turn(board)
#   end
#   if won?(board)
#     puts "Congratulations #{winner}!"
#   elsif draw?(board)
#     puts "Cat's Game!"
#   end
# end

# def play(board)
#   turn(board)
#   while over? == false
#     turn(board)
#   end
# end

#  new start

WIN_COMBINATIONS = [
  [0, 1, 2], #top rows
  [3, 4, 5], #middle rows
  [6, 7, 8], # bottom rows
  [0, 3, 6], #lvert
  [1, 4, 7], #mvert
  [2, 5, 8], #rvert
  [0, 4, 8], # diag1
  [2, 4, 6] # diag2
]

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

def move(board, input, value)
  board[input] = value
end

def position_taken?(board, index)
  if board[index] == " "
    false
  elsif board[index] == ""
    false
  elsif board[index] == nil
    false
  else board[index] == "X" || "O"
    true
  end
end

def valid_move?(board, index)
index.to_i.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip.to_i
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
  turn(board)
  end
end

def turn_count(board)
 counter = 0
  board.each do | space | #array element with 9 indexes, we're on the first space
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
  "X"
  else
  "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do | winning_combination |
    if board[winning_combination[0]] == "X" &&
       board[winning_combination[1]] == "X" &&
       board[winning_combination[2]] == "X" ||
       board[winning_combination[0]] == "O" &&
       board[winning_combination[1]] == "O" &&
       board[winning_combination[2]] == "O"
    return winning_combination
    end
  end
  false
end

def full?(board)
board.all? do |token|
  token =="X" || token =="O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
 else won?(board)
    false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  end
end

def winner(board)
  if winning_combination = won?(board)
    board[winning_combination[0]]
    end
  end

  def play(board)
    until over?(board)
      turn(board)
    end
    if winner(board) == "X"
    puts "Congratulations X!"
  else
    puts "Congratulations O!"
  end
    if draw?(board)
    puts "Cat's Game!"
      end
    end