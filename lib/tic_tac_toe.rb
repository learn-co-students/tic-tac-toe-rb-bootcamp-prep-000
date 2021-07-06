# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts (" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts ("-----------")
  puts (" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts ("-----------")
  puts (" #{board[6]} | #{board[7]} | #{board[8]} ")
end
#def position_taken?(board, index)
#  !(board[index].nil? || board[index] == " ")
#end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index=input_to_index(input)
  if valid_move?(board,index)
    move(board,index,name=current_player(board))
    display_board(board)
  else
   turn(board)
  end
end


def move(board,index,name)
     board[index] = name
end


def input_to_index(user_input)
   userinput=user_input.to_i
   userinput= userinput-1

end

# code your #valid_move? method here
def valid_move?(board, index)
  if position_taken?(board, index)
      false
    elsif index > board.length() || index < 0
     false
    else
     true
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
# code your #position_taken? method here!
def position_taken?(board, index)
   if  board[index] == " "
     false
   elsif board[index] == ""
     false
   elsif board[index] == nil
     false
   elsif board[index] == "X" || board[index] == "O"
    true
   end
end

def turn_count(board)
   numofturn=0
    board.each do  |n|
      if n == "X" || n == "O"
       numofturn += 1
      end
    end
    numofturn
end


def current_player(board)

     turn_count(board) %2 == 0  ? "X":"O"
end
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6] ]

def won?(board)

WIN_COMBINATIONS.each  do  |win_combination|
  #first ways
  if win_combination.all? {|a| board[a] == "X"} || win_combination.all? {|a| board[a] == "O"}
     return  win_combination
  end

 end
 return false
end

def full?(board)
  board.all? {|z| z == "X" || z == "O"}
end

def draw?(board)
   !(won?(board)) && (full?(board))
end

def over?(board)
   if won?(board) && !full?(board)
      true
  elsif  (draw?(board) || full?(board))
    true
  else
    false
end
end

def winner(board)
 if  won?(board)
   return  board[won?(board)[0]]
 else
   return nil
end
end
#current_player Define your play method below
def play(board)

      while !over?(board)
        turn(board)
      end
      if won?(board)
            puts "Congratulations #{winner(board)}!"
      elsif draw?(board)
            puts "Cat's Game!"
      end
end
