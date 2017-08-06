
def play(board)
  #pseudocode
  until over?(board) # until the game is over
    turn(board)#   take turns
  end # end over
  #
  if won?(board)# if the game was won
    puts "Congratulations #{winner(board)}!"#   congratulate the winner
  elsif draw?(board)# else if the game was a draw
    puts "Cats Game!"#   tell the players it has been a draw
  end
end


 # ******************************************************
 # from ttt-7
 # ******************************************************


 # code your #valid_move? method here
 def valid_move?(board,index)
   if index.between?(0,8)
     return !position_taken?(board,index)
   end
 end

# ******************************************************
# from ttt-9
# ******************************************************


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

# OLD PLAY  -remove after tests
# Define your play method below
# def play(board)
#   count = 0
#   until count >= 9
#     turn(board)
#     count+=1
#   end
# end

# ******************************************************
# from ttt-10
# ******************************************************

def turn_count(board)
  count = 0;
  board.each do |square|
    if square == "X" || square == "O"
      count +=1
    end
  end
  return count #return number of turns that have been played
end

def current_player(board)
  #use the #turn_count method to determine if it is "X"'s turn or "O"'s.
  #If the turn count is an even number, the #current_player method should return "X", otherwise, it should return "O".
  value = turn_count(board) % 2 == 0 ? "X" : "O"
end



# ******************************************************
# from ttt-game-status-bootcamp-prep-000
# ******************************************************
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


#The #full? method should accept a board and return true
#if every element in the board contains either an "X" or an "O". For example:
def full?(board)
  #[1,2,3,4].detect{|i| i.even?} #=> 2
  (board.select{|position| position== "X" || position=="O"}).length >= 9
  # puts (board.select{|position| position== "X" || position=="O"}).length

end
#
# board = ["X", "O", "X", "O", "X", "O", "O", "O", "X"]
# full?(board)



# check a tic tac toe board and return true if there is a win and false if not.
# For example, on a board that has a winning combination in the top row, #won?
# =>  should return [0,1,2], the indexes in the board that created the win:
# A board with no win would return false/nil:

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if position_taken?(board,combo[0]) && position_taken?(board,combo[1]) && position_taken?(board,combo[2])
      if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
        return combo
      end
    end #if
  end #WIN_COMBINATIONS
  return nil
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # last row
  [0,3,6], # Left row
  [1,4,7], # Middle vertical row
  [2,5,8], # Right row
  [0,4,8], # Top left to bottom right cross
  [2,4,6] # Bottom left to top right cross
  # ETC, an array for each win combination
]
#

# accepts a board and returns true if the board has not been won and is full
 # false if the board is not won and the board is not full,
 # false if the board is won
def draw?(board)
  draw = (won?(board).nil?)   && full?(board)
  # puts "won #{won?(board)}"  #no value if not won
  # puts "full #{full?(board)}"
  # puts "draw is #{draw}"
  # return draw
  # puts won?(board).nil?
end
# board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
# puts draw?(board)


 # returns true if the board has been won, is a draw, or is full.
def over?(board)
  over = !(won?(board).nil?) || draw?(board) || full?(board)
  # puts "won #{!(won?(board).nil?)}"  #no value if not won
  # puts "full #{full?(board)}"
  # puts "draw #{draw?(board)}"
end
# board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
# puts over?(board)


#winner?(board) # return the token, "X" or "O" that has won the game given a winning board.
def winner(board)
  # if win
  winning_combo = won?(board)
  if winning_combo.nil?
    return winning_combo
  end
  # puts "winning_combo #{winning_combo}"
  # puts board[winning_combo[0]]
  token = board[winning_combo[0]]
  # puts token.class

end
# board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
# puts winner(board)
