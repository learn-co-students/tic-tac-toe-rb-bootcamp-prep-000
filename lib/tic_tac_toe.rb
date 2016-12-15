WIN_COMBINATIONS = [
[0,1,2], # Top row 0
[3,4,5], # Middle row 1
[6,7,8], # bottom row 2

[0,3,6], # left column 3
[1,4,7], # middle column 4
[2,5,8], # right col 5

[0,4,8], # right diagonal 6
[2,4,6] # left diagonal 7
]

def display_board(board)  #Displays board :D
  lines = ["-----------"]
  puts [" #{board[0]} | #{board[1]} | #{board[2]} "]
  puts lines
  puts [" #{board[3]} | #{board[4]} | #{board[5]} "]
  puts lines
  puts [" #{board[6]} | #{board[7]} | #{board[8]} "]
end
##################################################### PADDING
def position_taken?(board,index)  #Checks to see if index is empty
  if board[index] == " "  ||  board[index] == ""  ||  board[index] == nil
    return false
  end
return true
end
#####################################################
def input_to_index(user_input)
  user_input.to_i - 1
end
#####################################################
def move(board, index, current_player) #what the hell is removing "X" breaking?
  board[index] = current_player
end
#####################################################
def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board, index)
end
#####################################################
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)           #if move's valid
    move(board, index, current_player(board)) #make move; removing def x req'd +current_player
    display_board(board)                 #show board
  else
    turn(board)                          #else invoke turn again
  end
end
#####################################################
def turn_count(board)
  count = 0
  for i in board
    if i == " "
      count +=0
    else
      count +=1
    end
  end
    return count
end
#####################################################
def current_player(board)        #THIS was the problem. Not being caled by turn.
  turn_count(board) % 2 == 0 ? "X" : "O"
end
#####################################################
def draw?(board)
	if !won?(board) && full?(board) #literally woudn't let me check full? first...
		return true 	                #if board’s full and no one’s won it’s a draw
	else
		return false
end
end
#####################################################
def over?(board)
	if full?(board)              #if the board's full
		return true                #the game's over
	end
return false                   # >_> otherwise it's not
end
#####################################################
def winner(board)
victor_krum = won?(board) ? board[won?(board)[0]] : nil
return victor_krum
end
#####################################################
def play(board)
 while !over?(board) && !won?(board) &&!draw?(board) #had to add won/board checks here
    turn(board)
  end
    if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
      puts "Cats Game!"
end
#####################################################
def full?(board)
	if board.include?(" ")       #if the board has any empty spaces, it's not full
		return false
	end
	return true
end
#####################################################
def won?(board) #Fixed! Not with a each/do or other new trick, but... way less ugly
for i in WIN_COMBINATIONS
  if board[i[0]] == "X" && board[i[1]] == "X" && board[i[2]] == "X"
    return i
  elsif board[i[0]] == "O" && board[i[1]] == "O" && board[i[2]] == "O"
    return i
  end
end
  return false
end
