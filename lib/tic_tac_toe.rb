
def position_taken?(board, index)
 !(board[index].nil? || board[index] == " ")
end

def move(board,index,character)
  board[index]=character
end

def display_board(board)
     puts " #{board[0]} " + "|" + " #{board[1]} " + "|" +  " #{board[2]} "
     puts "-----------"
     puts " #{board[3]} " + "|" + " #{board[4]} " + "|" +  " #{board[5]} "
     puts "-----------"
     puts " #{board[6]} " + "|" + " #{board[7]} " + "|" +  " #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

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

def won?(board)
 WIN_COMBINATIONS.each do |win_combination|
   win_index_1 = win_combination[0]
   win_index_2 = win_combination[1]
   win_index_3 = win_combination[2]

   position_1 = board[win_index_1]
   position_2 = board[win_index_2]
   position_3 = board[win_index_3]

   if ((position_1 == "X") && (position_2 == "X") && (position_3 == "X")) || ((position_1 == "O") && (position_2 == "O") && (position_3 == "O"))
     return win_combination
   end
 end
 return false
end

def full?(board)
board.each do |pos|
 if (pos.nil?) || (pos == " ")
   return false
 end
end
return true
end

def draw?(board)
 if full?(board) && !won?(board)
   return true
 else
   return false
 end
end

def over?(board)
 if draw?(board) || won?(board) || full?(board)
   return true
 else
   return false
 end
end

# def winner(board)
#  if draw?(board) || (  (full?(board)) && (!won?(board))  )
#    return 'nil'
#  elsif won?(board)[0]="X"
#    return "X"
#  else
#    return "O"
#  end
# end

def winner(board)
 if won?(board) != false
   return board[won?(board)[0]]
 else
   return nil
 end
end

def valid_move?(board,index)
  index.to_i
  if index.between?(0,8)
    if position_taken?(board,index)
      false
    else
      true
    end
  else
    false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board,index)
  index.to_i
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  index=input_to_index(input)
  if valid_move?(board,index)
    character=current_player(board)
    move(board,index,character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position_value|
    if ((position_value == "X") || (position_value == "O"))
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

# def play(board)
#    numTurns = 0
#    until numTurns == 9
#      	turn(board)

#      	numTurns += 1
#      	end
 # end

def play(board)
    until over?(board)
      turn(board)
    end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts 'Cats Game!'
end
end
