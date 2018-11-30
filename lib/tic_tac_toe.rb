#array combinations on the board that win the game
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

# this is the board 
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end 

# translates the player's input to an index on the board
def input_to_index(input)
  (0..10).include? input.to_i
  input.to_i - 1
end 

# how to play a mopve 
def move(board,index,current_player)
  board[index] = current_player
end 

# Has the position been taken already?
def position_taken?(board,index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false 
  else
    true 
  end 
end 

# Is the move valid? 
def valid_move?(board,index)
  if (0..8).include?(index) && position_taken?(board,index) == false
    true
  else
    false 
  end
end 

# a complete turn 
def turn(board)
  #get user input and convert to index 
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  #if index is valid make the move and display board
  if valid_move?(board,index) 
    move(board,index,current_player(board))
    display_board(board)
  #else prompt user to enter input again until move is valid / rinse & repeat
 else
    puts "Please enter 1-9:"
    input = gets.strip 
 end 
end

# counts the number of turns played by calculating length of the board selecting the X's and O's that are filled
def turn_count(board)
   board.select{|a| a=="X" || a=="O"}.length
end

# displays the current player based on turn count
def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end 
end 

#if there's no win combo, false. else, gives the winning combo. 
def won? (board)
   result = WIN_COMBINATIONS.map do |wincombo| 
    if (board[wincombo[0]]) == "X" && (board[wincombo[1]]) == "X" && (board[wincombo[2]]) == "X" 
      wincombo
    elsif (board[wincombo[0]]) == "O" && (board[wincombo[1]]) == "O" && (board[wincombo[2]]) == "O" 
      wincombo
    else
      false
    end 
   end 
    if result.all?{ |wincombo| wincombo == false}
      false
    else
      result.delete(false)
      result.flatten
    end   
end 

# Is the board full? 
def full? (board)
  if board.include?("") || board.include?(" ")
    false
  else
    true
  end 
end

# Was there a draw? 
def draw? (board)
  if won?(board) != false
    false
  elsif full?(board)
    true 
  else
    false
  end 
end 

# Is the game over? 
def over? (board)
  if won?(board) != false
    true
  elsif draw?(board)
    true
  else
    false
  end 
end 

# Who won? 
def winner (board)
  if won?(board) == false
    nil
  elsif board.count("X") > board.count("O")
    "X"
  else
    "O"
  end 
end 

# plays the game! 
def play (board)
  until over? (board)
    turn(board)
  end 
    if won? (board) 
      puts "Congratulations #{winner(board)}!"
    else draw? (board)
      puts "Cat's Game!"
    end 
end 