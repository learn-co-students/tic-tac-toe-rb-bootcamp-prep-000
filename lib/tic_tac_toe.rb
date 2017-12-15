require 'pry'

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]
def won?(board)
WIN_COMBINATIONS.detect do |j|

   (board[j[0]] === board[j[1]] && board[j[1]]===board[j[2]]) && (position_taken?(board,j[0] ))

end
end
def full?(board)
      if (board.index(" ") || board.index(" "))
      return false
    end
      return true
   end
def draw?(board)
  return ! won?(board) && full?(board)
end
def over?(board)
  return  won?(board) || full?(board) || draw?(board)
end
def winner(board)
  if won?(board) != nil
    win=won?(board)

    return board[win[0]]
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
    index=user_input.to_i - 1
    return index
  end
  def valid_move?(board,index)
  if ((index >=0 && index <=8)&& (board[index]=="" || board[index]=="" || board[index]==" " || board[index]==nil))
    return true
  else return false
  end

end

def move(array,index,value)
  array[index] = value
end

def turn(board)
  while  true
   puts "Please enter 1-9:"
   index=input_to_index(gets)
    if valid_move?(board,index)
       move(board, index, current_player(board))
       display_board(board)
       return
    end
  end
end
def turn_count(board)
  arr = board.reject { |e| (e === " " || e === nil) }
   return arr.length
 end
 def current_player(board)
   if  turn_count(board) % 2===0
     return "X"
   end
   return "O"
 end
 def play(board)
  while ! over?(board)
    turn(board)
  end
  if  won?(board)
  puts "Congratulations #{winner(board)}!"
  end
  if  draw?(board)
   puts  "Cat's Game!"
 end
 end
