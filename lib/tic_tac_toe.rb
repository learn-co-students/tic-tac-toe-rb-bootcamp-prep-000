WIN_COMBINATIONS = [
    [0, 1, 2], #Top Row 
    [3, 4, 5], #Middle Row 
    [6, 7, 8], #Bottom Row 
    [0, 3, 6], #First Column 
    [1, 4, 7], #Second Column 
    [2, 5, 8], #Third Column 
    [0, 4, 8], #Diagonal 1 
    [2, 4, 6], #Diagonal 2 
  ]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1 
  index 
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
counter = 0 
  board.each do | place |
    if place == "X" || place == "O"
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
  WIN_COMBINATIONS.detect do |combos|
    board[combos[0]] == board[combos[1]] && board[combos[1]] == board[combos[2]] &&
    position_taken?(board, combos[0])
  end
end

def full?(board)
  board.all? do |spot|
    spot == "X" || spot == "O"
  end 
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end


# Define your play method below

def play(board)
  until over?(board)
    turn(board)
  end
  
   if won?(board)
        puts "Congratulations #{winner(board)}!"
      else
        puts "Cat's Game!"
   end
end