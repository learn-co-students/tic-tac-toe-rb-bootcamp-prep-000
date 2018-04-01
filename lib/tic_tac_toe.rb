WIN_COMBINATIONS = [
  #Top row
  [0, 1, 2],
  #Middle row
  [3, 4, 5],
  #bottom row
  [6, 7, 8],
  #left Column
  [0, 3 ,6],
  #Middle Column
  [1, 4, 7],
  #Right Column
  [2, 5, 8],
  #Diagonal 1
  [0, 4, 8],
  #Diagonal 2
  [2, 4, 6]
  ]
  
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
  count = 0
  board.each do |space|
    if space == "O" || space == "X"
      count+=1
    end
  end 
  return count
end

def current_player (board)
  if turn_count(board) % 2 == 0
    return "X"
  else 
    return "O"
  end 
end 


def won? (board)
 #Iterates through winning combinations list
  WIN_COMBINATIONS.each do |combination|
    
    #creates counters which reset with every new combination
    x_count = 0
    o_count = 0
    
    #iterates through every combation
     combination.each do |space|
       #checks to for matching X
       if  board[space] == "X"
         x_count += 1
         
        #checks for Matching O 
         elsif board[space] == "O"
         o_count += 1
       end
       
       #checks to see if there is 3 matches of either kind
       if (x_count == 3 || o_count ==3)
         return combination
       end
    end 
  end
  return false
end

def full? (board)
board.all? do |space|
  space == "X" || space == "O"
end 
end 


def draw?(board)
  if won?(board)
    return false
    elsif full?(board)
    return true 
  end 
end 

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
end 
end 


def winner(board)
  combination = won?(board)
  if combination == false
    return nil
  elsif board[combination[1]] == "X"
    return "X"
  else 
    return "O"
  end 
end 

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
