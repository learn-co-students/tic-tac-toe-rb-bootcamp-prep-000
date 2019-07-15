WIN_COMBINATIONS = [
  #horizontal
  [0, 1, 2], 
  [3, 4, 5], 
  [6, 7, 8],
  
  #vertical
  [0, 3, 6], 
  [1, 4, 7], 
  [2, 5, 8], 
  
  #diagonal
  [0, 4, 8], 
  [2, 4, 6],
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
  if(board[location] != " " && board[location] != "")
    return true 
  else 
    return false
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if(valid_move?(board, index))
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  9.times do |i|
    if(position_taken?(board, i) == true)
      count+=1
    end
  end
  return count
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def won?(board)
    
    x_count = 0
    o_count = 0
    
    WIN_COMBINATIONS.each do |i|
      i.each do |j|
        if(board[j] == "X")
          x_count+=1
        end
        if(board[j] == "O")
          o_count+=1 
        end
      end
      if(x_count == 3 || o_count == 3)
        return i.to_ary
        return true
        break
      else 
        x_count = 0 
        o_count = 0
      end
    end
    
    if(x_count != 3 && o_count != 3)
      return false 
    end
    
    board.each do |i|
      if(i == " ")
        return false
      end
    end
  end
  
  def full?(board)
    count = 0
    board.each do |i|
      if(i != " ")
        count+=1 
      end
    end
    if(count == 9)
      return true
    else  
      return false
    end
  end
  
  def draw?(board)
    if(won?(board) == false && full?(board) == true)
      return true
    else 
      false 
    end
  end
  
  def over?(board)
    if( won?(board) == true || draw?(board) == true || (won?(board) && full?(board) == true) || (won?(board) && !full?(board) == true))
      return true 
    else 
      return false
    end
  end
  
  def winner(board)
      if(won?(board))
        return board[won?(board)[0]]
      end
  end
  
  

# # Define your play method below

def play(board)
  until (over?(board))
    turn(board)
  end
  
  if(won?(board))
    puts "Congratulations " + winner(board) + "!"
  elsif(draw?(board))
    puts "Cat's Game!"
  end
  
end





