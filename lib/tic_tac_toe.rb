WIN_COMBINATIONS = [
  [0, 1, 2], 
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6],
  [0, 4, 8]
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

def move(board, index, player)
 board[index] = player
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true 
  end
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  if valid_move?(board, index)
    return move(board, index, current_player(board)) && display_board(board)
   else
    return turn(board)
  end
end

 
def turn_count(board)
  counter = 0 
  board.each do |symbol|
    if symbol == "X" || symbol == "O"
      counter += 1
    end
  end
  return counter
end


def current_player(board)
  #if turn_count(board) % 2 == 0 
    #return "X"
  #else
    #return "O"
  #end
  turn_count(board) % 2 == 0 ? "X" : "O"
end


def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
      first_index = win_combo[0]
      second_index = win_combo[1]
      third_index = win_combo[2]
      
      if board[first_index]  == "X" && board[second_index] == "X" && board[third_index] == "X"
          return win_combo
      elsif board[first_index] == "O" && board[second_index] == "O" && board[third_index] == "O"
          return win_combo
      end
    end
  return false
  end
  
  
  def full?(board)
    board.all? {|i| i == "X" || i ==  "O"}
  end
  
  
  def draw?(board)
    if !won?(board) && full?(board) 
      return true
    else
      return false
    end
  end
  
  
  def over?(board)
    if won?(board) || full?(board) || draw?(board)
      return true
    else
      false
    end
  end
  

def winner(board)
   if !won?(board)
     return nil
    else
      if board[won?(board)[0]] == "O"
       return "O"
      else 
         return "X"
      end
    end
 end
 
 
 
 def play(board)
  
   until over?(board)
    turn(board)
   end
   if won?(board)
     puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
    puts "Cat's Game!"
   end

end
