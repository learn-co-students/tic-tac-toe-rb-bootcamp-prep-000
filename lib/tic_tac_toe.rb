


WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
  
  def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
      index_one=win_combo[0]
      index_two=win_combo[1]
      index_three=win_combo[2]
      if ((board[index_one]=="X" && board[index_two]=="X" && board[index_three]=="X") || (board[index_one]=="O" && board[index_two]=="O" && board[index_three]=="O"))
        return win_combo
      end
    end
    return false
  end
  
  def full?(board)
    board.all? {|element| (element=="X" || element=="O")}
  end
 
def draw?(board)
  if (!won?(board) && full?(board))
    return true
  elsif (!won?(board)  && !full?(board))
    return false
  elsif won?(board)
    return FALSE
  end
end
 
def over?(board)
  if (won?(board) || draw?(board) || full?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) 
    if board[won?(board)[0]]=="X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return (user_input.to_i-1)
end

def move(array,index,value)
  array[index]=value
  return array
end

def valid_move? (board,index)
  if ((index.between?(0,8)) && (!position_taken?(board,index)))
    return TRUE
  else
    return false
  end
end

def turn_count(board)
  counter=0
  board.each do |element|
    if element=="X" || element=="O"
      counter+=1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board)%2==0
    "X"
  else
    "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input=gets.strip
  index=input_to_index(user_input)
  if (valid_move?(board, index))
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  
#Need to alternate players 

  until over?(board)
    turn(board)
  end
  
  if won?(board) && winner(board)=="O"
    puts "Congratulations O!"
  elsif won?(board) && winner(board)=="X"
    puts "Congratulations X!"  
  else
    puts "Cat's Game!"
  end

end