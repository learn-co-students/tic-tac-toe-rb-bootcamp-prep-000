board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2], # top row 
  [3,4,5], # middle row
  [6,7,8], # bottom row 
  [0,3,6], # left row
  [1,4,7], # center row 
  [2,5,8], # right row 
  [0,4,8], # diagonal left to right 
  [6,4,2]  #diagonal right to left 
  ]
  
def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
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

def turn_count(turns)
  counter = []
  turns.each do |turn|
    if turn == "X" || turn == "O"
      counter << 1 
    end
  end 
  counter.length.to_i 
end 

def current_player(board)
    num = turn_count(board) 
   if num.even?
      return "X"
    else
      return "O"
    end
  end

def full?(board)
  !board.any? { |x| x == " " }
end 
  
def won?(board)
  WIN_COMBINATIONS.detect do |arr| 
  if board[arr[0]] == "X" && board[arr[1]] == "X" && board[arr[2]] == "X"
    arr
  elsif board[arr[0]] == "O" && board[arr[1]] == "O" && board[arr[2]] == "O"
    arr
  else
    false
  end
end 
end
  
def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
if answer = won?(board)
  board[answer.first]
else
  nil
end
end  

def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
