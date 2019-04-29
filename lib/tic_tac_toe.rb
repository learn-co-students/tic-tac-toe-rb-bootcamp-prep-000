require "pry"

board = [" "," "," "," "," "," "," "," "," "] 


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end 


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def input_to_index(user_input)
  user_input = user_input.to_i - 1
end 


def move(board, index, current_player)
  board[index] = current_player
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn_count(board)
  count = 0
  board.each do |index|
 if index == "X" || index == "O"
  then count += 1  
end
end
return count
end


def current_player(board)
  if turn_count(board).even?  
    return "X"
  else 
    return "O"
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


# Define your WIN_COMBINATIONS constant
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


def won?(board)
 WIN_COMBINATIONS.each do |combo| 
  if position_taken?(board, combo[0]) && board[combo[0]] === board[combo[1]] && board[combo[1]] === board[combo[2]] 
   return combo
end 
end
return false
end 


def full?(board)
  if board.all? {|token| token == "X" || token == "O"} 
      return true
    end
  return false 
end 


def draw?(board)
if full?(board) && !(won?(board)) 
  true  
else false 
end 
end 


def over?(board)
if draw?(board) || won?(board)
  true
else false 
end 
end 


def winner(board) 
  if won?(board)
    WIN_COMBINATIONS.each do |combo| 
      if position_taken?(board, combo[0]) && board[combo[0]] === board[combo[1]] && board[combo[1]] === board[combo[2]] 
    return board[combo[0]]   
end 
end
end 
end 


def play(board)
   until over?(board)
   turn(board)
end 
  if  won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif  draw?(board)
  puts "Cat's Game!"
end 
end