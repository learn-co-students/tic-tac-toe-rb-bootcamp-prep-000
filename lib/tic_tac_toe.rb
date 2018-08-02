


WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def full?(board)
 board.all? {|c| (c=="X")||(c=="O")}
end

def over?(board)
  in_progress= false
  if(won?(board)||draw?(board)||full?(board))
 return true
 end
  if full?(board)==false 
  return false
  end

end

def winner(board)
  
if won?(board)
  
  return board[won?(board)[0]]
 end
end


def won?(board)
  
  is_empty = board.none? { |c| c=="O" || c=="X" }
 if(is_empty)
  return false
 else

  WIN_COMBINATIONS.each do |win_combination|
    
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    

     if(((position_1=="X")&&(position_2=="X")&&(position_3=="X"))||((position_1=="O")&&(position_2=="O")&&(position_3=="O")))
      
    return win_combination

    end
  
  end
  false
 end

end

def position_taken?(board,index)
  if board[index]=="X" || board[index]=="O"
  true
else
  false
 end
end

def valid_move?(board, index)
  if((index.between?(0,8)) && !(position_taken?(board,index)))
    true
  else
    false
 end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!

def input_to_index(user_input)
num = (user_input.to_i - 1)
end

def move(board, position,player)
 board[position]=player
end

def turn_count(board) 
 counter =0
 board.each do |turns|
   if ((turns=="X")||(turns=="O"))
     counter+=1
   end
end
counter
end


def current_player(board)
  total_turns = turn_count(board)
    (total_turns.even?) ? "X" : "O"
  
end

def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip
  index = input_to_index(number)
  if valid_move?(board,index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def draw?(board)
 !won?(board) && full?(board) ? true: false
end

def play(board)

until over?(board)
current_player(board)
turn(board)
end
if(won?(board))
  puts "Congratulations #{winner(board)}!"
else 
  puts "Cat's Game!"
end
end




















