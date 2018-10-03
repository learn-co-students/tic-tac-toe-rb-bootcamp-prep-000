#helper methods

#constant
WIN_COMBINATIONS = [
  [0,1,2], #Top row   
  [3,4,5], #Middle row 
  [6,7,8], #Bottom row
  [0,3,6], #Left column
  [1,4,7], #Middle column
  [2,5,8], #Right column
  [6,4,2], #Diagonal one 
  [0,4,8] #Diagonal two 
]

#prints current board 
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "  
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  
end
 
#convert user input to board index
def input_to_index(user_input)
  user_input.to_i - 1
end

#player's move 
def player_move(board, index, current_player)  
  board[index] = current_player
end

#board index vacancy
def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  if index.between?(0,8)
    if !position_taken?(board, index)
      true 
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"  
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
      #move based on input 
      player_move(board, index, current_player(board))
      
      #display board after valid move 
      display_board(board)
    else
      #ask for valid input 
      turn(board)
    end
end

def turn_count(board)
  board.count {|token| token == "X" || token == "O"} 
end 

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end 

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] &&
    board[win_combination[1]] == board[win_combination[2]] &&
    position_taken?(board, win_combination[0])
  end
end 

def full? (board)
  board.all?{|token| token == "X" || token == "O"} 
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end 

def winner(board)
  if win_combination = won?(board)
    board[win_combination.first]
  end 
end 

def play(board)
  while !over?(board)
    turn(board)
  end 
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end 
end 




