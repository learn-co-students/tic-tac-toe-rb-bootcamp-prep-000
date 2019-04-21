WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
  ]
  board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  
def display_board(board)

puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

end
  
def input_to_index(input)
input = input.to_i
input - 1
end

def move(board, index, token)
  
board[index] = token
board
end

def position_taken?(board, index)
if board[index] == " "
  false
else
  true
end
end

def valid_move?(board, index)

if (index < 9) && (index >= 0) && board[index] == " "
  true
    else
  false
end
end

def turn(board)

  puts "Please enter 1-9:"
  movey = gets.strip
  movey = input_to_index(movey)
  if valid_move?(board, movey)
  move(board, movey, current_player(board))
  display_board(board)
else
  turn(board)
end

end
  
def turn_count(board)
  counter = 0
  board.each do |val|
    if val == "X" || val == "O"
      counter += 1
    else
  end
  end
  counter
end

def current_player(board)

turncount = turn_count(board)
if turncount % 2 == 0
  "X"
else
  "O"
end

  
end
  
  def won?(board)
    gotxwin = false
    gotowin = false
    windex = []
  WIN_COMBINATIONS.each do |blah| 
    
   if blah.all?{|numb| board[numb] == "X"}
   gotxwin = true
   windex = blah
  
   elsif blah.all?{|numb| board[numb] == "O"}
   gotowin = true
   windex = blah
  end
  
  end
  
   if gotxwin && gotowin
    [d, r, a, w]
  elsif gotxwin || gotowin
    windex
  else
  false
  end
  
  
end
  
def full?(board)
  
board.all?{|token| token == "X" || token == "O"}
  
end  
  
  
def draw?(board)
  
  if !won?(board) && full?(board)
    true
  else
    false
  end
    
end 
 
 
def over?(board)

if won?(board) || draw?(board) || full?(board)
  true
else
  false
end
   
end

def winner(board)
  
if !won?(board)
    nil  
  
  elsif board[won?(board)[0]] == "O"
 "O"
 elsif board[won?(board)[0]] == "X"
 "X"
 
 end
 
end

def play(board)
  until over?(board)
  turn(board)
end
if winner(board)
  puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
  puts "Cat's Game!"
end
end
