# Define your WIN_COMBINATIONS constant
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

# Helper Methods
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
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  counter=0
  while(counter<9) do

    if !over?(board)
      turn(board)
    elsif draw?(board)
      puts "Cat's Game!"
    elsif won?(board)
      puts "Congratulations #{winner(board)}!"
    end
    counter+=1
  end
end

def turn_count(board)
  counter=0
  board.each do |slot|
    if(slot=='X' || slot=='O')
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board)%2==0 ? "X" : "O"
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end



def won?(board)

  all_empty = board.all? do |ele|
    ele == " "
  end

  if(all_empty)
    return false
  end

  WIN_COMBINATIONS.each do |array|
    position_1=board[array[0]]
    position_2=board[array[1]]
    position_3=board[array[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return array
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return array
    else
      false
    end
  end

  all_taken = board.all? do |ele|
    ele == "X" || ele == "O"
  end
  if(all_empty)
    return false
  end
end

def full?(board)
  i=0
  while i<board.size
    if !position_taken?(board,i)
      return false
    end
    i+=1
  end
  return true
end

def draw?(board)
  !won?(board) && full?(board)

#  if won?(board)
#    return false
#  elsif !won?(board) && full?(board)
#    return true
#  elsif !won?(board) && !full?(board)
#    return false
#  end
end


def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
 if won?(board)
   return board[won?(board)[0]]
 end
end
