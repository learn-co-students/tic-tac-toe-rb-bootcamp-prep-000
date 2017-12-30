# Define your play method below
def play(board)
i = 0
until over?(board)  
i += 1
display_board(board)
turn(board)
end
if won?(board) != false
  puts "Congratulations #{winner(board)}!"
   
elsif draw?(board) 
  puts "Cat's Game!"
end
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





def turn_count(board) 
  turn = 0 
  board.each do |index|
    if index == "X" || index == "O"
    turn += 1
  end 
end 
turn 
end 

def current_player(board)
  turn_count(board).even? ? "X" : "O" 
end 
  
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
WIN_COMBINATIONS = [ 
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,3,6],
   [1,4,7],
   [2,5,8],
   [0,4,8],
   [6,4,2],
  ]
  
def won?(board)
  WIN_COMBINATIONS.each{|win| 
  if win.all?{|i| board[i] == "X"}
   return win 
  elsif win.all?{|i| board[i] == "O"}
  return win
  
end}
false 
end

def full?(board) 
if board.none?{|i| i == " "} && board.none?{|i| i == ""}
  true 
else
false
end  
end

def draw?(board) 
if full?(board)
    if won?(board) == false
  true 
end 
  else 
   return false 
  end 
end

def over?(board)
    if draw?(board)
      true
    elsif won?(board) == false  
       false 
    elsif won?(board) != false
     return true 
    elsif board.any?{ |i| i == " "}
    return false 
    else 
      false
  end
end

def winner(board)
  if won?(board) == false
    nil
  elsif won?(board).all?{ |i| board[i] == "X"} 
    "X"
  elsif won?(board).all?{ |i| board[i] == "O"}
    "O"
  else 
    nil 
  end
end
