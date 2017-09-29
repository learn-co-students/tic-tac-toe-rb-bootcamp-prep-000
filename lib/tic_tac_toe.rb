def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
#*************************
def won?(board)

  won=WIN_COMBINATIONS.detect { |combination|
    board[combination[0]]==board[combination[1]] && board[combination[1]]==board[combination[2]] && board[combination[1]]!=" "
  }

  if won==nil
    return false
  else
    return won
  end
end
#**************************************
def full?(board)
  #return true
  count=0
  board.each {|cell|
  if (cell=="X" || cell=="O")
    count+=1
  end
  }
  if count==9
    return true
  else
    return false
  end

end
#***************************
def draw?(board)
  if (full?(board) && !won?(board))
    return true
  elsif (!full?(board) && !won?(board))
    return false
  else
    return false
  end
end
#*****************************
def over?(board)
 if full?(board) || won?(board) || draw?(board)
   return true
 else
   return false
 end
end
#********************************
def winner(board)
if !won?(board)
  return nil
end
return board[won?(board)[0]]

end
#*********************
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

#******************************************
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
#*******************************************
def move(board, index, current_player = "X")
  board[index] = current_player(board)
end
#*******************************************
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
#******************************************
def turn_count(board)
  count=0
  board.each {|cell|
    if (cell=="X" || cell=="O")
      count+=1
    end
    }
    return count
end
#*************************************8
def current_player(board)
  count=turn_count(board)
  if (count%2==1)
    return "O"
  else
    return "X"
  end

end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  puts "Welcome to Tic Tac Toe!"
  display_board(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    puts "#{winner(board)} wins!"
  end
  if draw?(board)
    puts "Game over! Noone wins."
  end
end

play(board)
