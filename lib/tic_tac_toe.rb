WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [2, 4, 6],
  [0, 4, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} " 
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i
  index - 1
end

def move(board,input,x)
  board[input] = x
end

def position_taken?(board,index)
  if board[index] == " " ||
    board[index] ==  "" || 
    board[index] == nil
   return false 
  else
   return true
  end
end

def valid_move?(board,index)
    if position_taken?(board, index) == false && 
      index.between?(0, 8) == true 
     return true
    else false
  end
end
 
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  user_input = input_to_index(input)
    if valid_move?(board, user_input) == false
    turn(board)
    else
    move(board,user_input,x)
    end
  display_board(board)
end

def turn_count(board)
  counter = 0 
  board.each do |x| 
  if x == "X"
    puts "#{counter}"
    counter += 1
end 
end

board.each do |x| 
  if x == "O"
    puts "#{counter}"
    counter += 1
end 
end 
return counter
end

def current_player(board)
  (turn_count(board)% 2 == 0 ? "X" : "O")
end

def won?(board)
           WIN_COMBINATIONS.each do |wins|
            if wins.all?{|win_index| 
              board[win_index] == "X"} ||  
              wins.all?{|win_index| 
                board[win_index] == "O"}
                return wins
              end
              end
              return false
end

def full?(board)
    board.all? {|index| index == "X" || index == "O"}
  end
  
 def draw?(board)
  if full?(board) == true &&
    won?(board) == false 
    return true 
  end
end 

 def over?(board)
  if won?(board) && !full?(board) ||
    draw?(board) == true ||
    full?(board) == true 
    return true 
  else 
    return false 
  end 
    end
    
 def winner(board)
   x = board.select {|x| x == "X"}
   o = board.select {|o| o == "O"}
   
   if won?(board)  &&
     x.length > o.length 
     return "X"
   elsif won?(board) &&
     o.length > x.length
     return "O"
   else 
     nil 
 end
end 

def play(board)
  if over?(board) == false
  turn(board)
elsif over?(board) == true && 
draw?(board) == true
puts "Cat's Game!"
elsif won?(board) == "X"
puts "Congratulations X!"
elsif won?(board) == "O"
puts "Congratulations O!"
end 
end 
 