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

#   puts "moving " + index.to_s
  index = input_to_index(input)
if valid_move?(board, index)
#    puts "moving " + index.to_s
    currplay = current_player(board)
    move(board, index, currplay)
    display_board(board)
#    if currplay == "X"
#       currplay = "O"
#     else
#       currplay = "X"
#     end
else
  puts "What the fuck"
  turn(board)
end
end


# Define your play method below

def play(board)
 count = 0 
  while !over?(board)
#    puts "Count = " + count.to_s
    turn(board)
  count += 1
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end


def turn_count(board)
  counter = 0
  board.each do |boardindex| 
    if boardindex == "X" || boardindex == "O"
      counter = counter + 1
    # puts "element #{counter} #{boardindex}"
    end
  end
  return (counter)
end

def current_player(board)
  turncount = turn_count(board)
  if turncount % 2 == 0 
    return "X"
  else
    return "O"
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # bottom row
  [0,3,6],# left col
  [1,4,7], #center col
  [2,5,8], # right col
  [0,4,8], # TL-BR diag 
  [6,4,2], # BL-TR diag
  # ETC, an array for each win combination
]
def won?(board)
  for win_combination in WIN_COMBINATIONS do
  
      win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
 
  position_1 = board[win_index_1] # load the value of the board at win_index_1exi
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3
 # puts "win index combination #{win_index_1} - #{win_index_2} - #{win_index_3}"
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination # return the win_combination indexes that won.
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
   return win_combination
  else
   loopflag = false
  end
end
return false
end 
#full
def full?(board)
  index = 0 
  while index < 9 
    if board [index]==nil || board[index]== " "
      return false
    end
    index += 1
  end
  return TRUE
  
end

def draw?(board)
  fullflag=full?(board)
  
  if won?(board)
    return false
  else
    return fullflag
  end
  #if fullvar  && !won?(board)
  #  return true 
  #elsif !fullvar && !won?(board)
  #  return false
  #else
  #  return false
  #end
end

# over 
def over?(board)
  return( won?(board) || draw?(board) || full?(board))
end

def winner(board)
  index=won?(board)
  if !index
    return NIL
  else 
    return board[index[0]]
    
  end
end



