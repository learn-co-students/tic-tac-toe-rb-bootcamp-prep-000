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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
  turns = 0 
  
  board.each do |position|
    if (position == "X" || position == "O")
      turns += 1 
    else 
    end 
  end 
 
  turns 
end

def current_player(board)
  
  if turn_count(board).even? 
    return "X"
  else turn_count(board).odd?
    return "O"
  end 

end 

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
      if ((position_1 == "X" && position_2 == "X" && position_3 == "X") ||     (position_1 == "O" && position_2 == "O" && position_3 == "O"))
         return win_combination
      else 
    end 
  end 
    return nil 
 end
 
 def full?(board)
   counter = 0 
   board.each do |position|
     if (position == "X" || position == "O")
       counter +=1 
     else 
     end 
   end 
   if counter == 9 
     return true 
   else 
     return false 
   end 
 end 
 
 def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end 
 end 
 
 def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else 
    return false 
  end 
 end 
 
 
 def winner(board)
  if won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      position_1 = board[win_combination[0]]
      position_2 = board[win_combination[1]]
      position_3 = board[win_combination[2]]
      if (position_1 == "X" && position_2 == "X" && position_3 == "X")
        return "X"
      elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return "O"
      else
        
      end
    end
  else
    return nil
  end
end

def play(board)
  turn = 0 
  while turn < 9 
    turn(board)
    turn += 1 
  end 
end 

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    #do nothing
  end
end