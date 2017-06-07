
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if index<0 || index>8
    return false
  elsif position_taken?(board,index)
    return false
  end
  true
end

def turn_count(board)
  x = board.select do |n|
    n==" "
  end
  9-x.length
end

def current_player(board)
  if(turn_count(board)%2==0)
    return "X"
  else
    "O"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  #1st col
  [1,4,7],  #2nd col
  [2,5,8],  #3rd col
  [0,4,8],  #diagonal R
  [2,4,6],  #diagonal L
]

def won?(board)
  WIN_COMBINATIONS.each do |(x,y,z)|
    if board[x] == "X" && board[y] == "X" && board[z] == "X"
      return x,y,z # return the win_combination indexes that won.
    elsif board[x] == "O" && board[y] == "O" && board[z] == "O"
      return x,y,z
    end
  end
  false
end

def full?(board)
  board.none?{|i| i==" "}
end

def draw?(board)
  if(won?(board).is_a? Array)
    return false
  else
    full?(board)
  end
end

def over?(board)
  if draw?(board) || (won?(board).is_a? Array)
    return true
  end
  false
end

def winner(board)
  x=won?(board)
  if(x.is_a? Array)
    return board[x[0]]
  end
  nil
end

def display_board(brd)
  puts " #{brd[0]} | #{brd[1]} | #{brd[2]} "
  puts "-----------"
  puts " #{brd[3]} | #{brd[4]} | #{brd[5]} "
  puts "-----------"
  puts " #{brd[6]} | #{brd[7]} | #{brd[8]} "
end

def input_to_index(x)
 x.to_i-1
end

def move(arr, ind, pla)
  arr[ind]=pla
end

def turn(board)
  puts "Please enter 1-9"
  input = gets.strip

  if !valid_move?(board, input_to_index(input))
    turn(board)
  end
    move(board, input_to_index(input), current_player(board))
    display_board(board)

end

def play(board)

  while !over?(board) do
    turn(board)
  end

  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif(draw?(board))
    puts "Cats Game!"
  end
end
