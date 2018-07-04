board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [0, 4, 8],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6],
  
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input = input.to_i - 1
  input
end

def position_taken?(board, index)
  !(board[index] == nil || board[index] == " ")
end

def valid_move?(board, index)
     if index.between?(0,8) && !position_taken?(board, index)
       return true
     end
   end

 def move(board, index, player) #no longer using X's or O's as a default value
     board[index] = player
   end

#def turn(board) #old turn_condition that rendered true and passed tests. Problem is that it marks all X's.
  #puts "Please enter 1-9:"
  #input = gets.strip
  #index = input_to_index(input)
  #if valid_move?(board, index)
    #move(board, index, character = "X")
    #display_board(board)
  #else
    #turn(board)
  #end
#end

def turn(board) 
  puts "Please enter 1-9:"    
  input = gets.strip   
  index = input_to_index(input)     
  if valid_move?(board, index)
     move(board, index, current_player(board))
     else 
     turn(board)
   end           
   display_board(board)
end

def turn_count(board)
  counter = 0 
  board.each do |positions|
    if positions == "X" || positions == "O"
      counter += 1
    end
end
counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 =="O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end

  end
else
  false
end


def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true 
  else 
    return false
  end
end

def winner(board)
  if !won?(board)
    return nil 
   end
    if win_combination = won?(board)
      return board[win_combination[1]]
    end
  end

def play(board) #<= I believe I have written this one out correctly because it plays until the game is over (pun intended!)
  until over?(board) # plays game until it's over
    turn(board) #players will keep taking turns
  end
  if won?(board) 
      winner(board) == "X" || winner(board) == "O" #Calling winner method to check for winning condition
        puts "Congratulations #{winner(board)}!" #winning message
    elsif draw?(board)  #draw condition
      puts "Cat's Game!" # message when the game ends in a draw
    end
  end
