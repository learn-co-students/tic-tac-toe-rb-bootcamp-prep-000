WIN_COMBINATIONS = [
[0, 1,2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[0, 4, 8],
[2, 4, 6]]

#Output board

def display_board(
board = [[" ", " ", " ",
   " ", " ", " ", " ",
   " ", " "])
   puts 'display board'
#board output
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Change info to Integer

def input_to_index(move)
  index = move.to_i
  -1
  index
end

#Make turn

def turn(board)
  puts "Please enter 1-9:"
  #gets the user input
  user_input = gets.strip
  #inputs to index
  index = input_to_index(user_input)
  token = current_player(board)

  #check for validation
  if valid_move?(board, index)
   puts 'valid move'
   move(board, index, token)
   display_board(board)
 else
   puts 'try again'
   turn(board)
 end
 display_board(board)
end

#CHECK FOR EMPTY SPACE
def position_taken? (board, index)
  !(board[index].nil? || board[index] == " ")
end

#Correct and empty space

def valid_move?(board, index)

  if index.between?(0,8) && !position_taken?(board, index)
      puts 'this is a valid move'
    return true
  else
   return false
  end
end

#Counter for player assesment
def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
    counter += 1
  end
end
return counter
end

#Which player is this?
def current_player(board)
  if turn_count(board)%2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
  return current_player
  end

#Make move on board
def move(board, index, token)
  board[index] = token
  play(board)

end

#Has anyone won?

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    #check for player 1 win_combo
    if check_win_combination?(board, 'X', win combo)
      return win_combo
     #check for player 2 win
   elsif check_win_combination(board, 'O', win_combo)
     return win_combo
   else
     return false
   end
 end
end
