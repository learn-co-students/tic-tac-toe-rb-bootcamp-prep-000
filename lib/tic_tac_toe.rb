# Winning cobinations
WIN_COMBINATIONS = [
  [0,1,2],  #Top row
  [3,4,5],  #Middle row
  [6,7,8],  #Bottom row
  [0,3,6],  #First column
  [1,4,7],  #Seccond column
  [2,5,8],  #Third column
  [0,4,8],  #Diaginal top left to bottom right
  [2,4,6]   #Diaginal top right to bottom left
]

#Prints the board in the console
def display_board(board)
  seperator = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts seperator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts seperator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Play the game until the board is full or someone has won
def play(board)
  turns = 0
  until turns == 9
    turns += 1
    turn(board)
  end
end

#Pormps player for a move selection then checks if its valid and makes the move
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

#Check to make sure the position entered is valid and empty
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#Put the players symbol in the selected postion
def move(board, index, current_player)
  board[index] = current_player
end

#Convert the user input to to the board array index
def input_to_index(user_input)
  user_input.to_i - 1
end

#Ensure the position is empty
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#Check to see if X or O has completed a winning combination
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if combo.all? { |i| board[i].downcase == "x"}
      return combo
    elsif combo.all? { |i| board[i].downcase == "o"}
      return combo
    end
  end
  return false
end

#Check for a full game board
def full?(board)
  board.all? { |e| !(e.nil? || e == " ") }
end

#Check to see if the game ends in a draw
def draw?(board)
  !won?(board) && full?(board)
end

#Check if the game is over because someone won or the game is a draw
def over?(board)
  won?(board) || draw?(board)
end

#Return the winner
def winner(board)
  if !won?(board)
    return nil
  else
    board[won?(board)[0]]
  end
end
