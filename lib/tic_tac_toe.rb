# Helper Method
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
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, position, char)
  board[position]=char
  return board
end

def position_taken?(board, index)
 if board[index]== "" || board[index] == nil || board[index] == " "
    return false
  else
    return true
  end
end



def valid_move?(board, index)
  if !position_taken?(board,index) && index.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    
    if valid_move?(board, index)
      move(board, index)
      display_board(board)
    end
    
end

# Define your play method below
def play(board)
      until over?(board)
          play(board)
      end
      if draw?(board)
        puts "Cat's Game!"
      end
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      end 
   
end

def full?(board)
  if board.include?(" ")
    return false
  else
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) 
    return board[won?(board)[0]]
  else
    return nil
  end
end
  

  
def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def won?(board)
  #check each of the combos of wins
  win = true
  WIN_COMBINATIONS.each do |combo|
    #puts "combo is #{combo}"
    # see if all the letters in those indeces are the same letter
    win = true
    combo.each do |index|
      #puts "index being checked is #{index}"
      #get the winning combos indeces
      #puts " letter at position is #{board[index]} first position is #{board[combo[0]]}"
      if board[index] != board[combo[0]] #compare each index with first
        #puts "lost at 1"
        win = false
      end
      if board[index] == " "
        #puts "lost at 2"
        win =  false
      end
      
    end
    
    #puts "win is #{win}"
    
    if win == true
      #puts "winning combo is #{combo}"
      return combo
    end
    
  end
  #puts "checked all"
  return win
end


def turn_count(board)
  count = 0
  board.each do |turn|
    if turn != "" && turn != " " && turn != nil
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

#won?(["X", "O", "X", "O", "X", "X", "O", "X", "O"])