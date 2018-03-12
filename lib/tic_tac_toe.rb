# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]


#INPUT_TO_INDEX(user_inpt)
def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

#MOVE
def move(board, position, value = "X")
  board[position] = value
end
#DISPLAY_BOARD
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = g
end


#POSITION_TAKEN?
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#VALID_MOVE
def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0, 8)
    return true
  else
    return false
  end
end

#FULL?
def full?(board)
  return !(board & [" ", "", nil]).any?
end

#DRAW?
def draw?(board)
  if won?(board) == false
    return true
  elsif full?(board) == true && won?(board) == false
    return true
  elsif full?(board) == false && won?(board) == false
    return false
  end
end

#OVER
def over?(board)
  if full?(board) == false && won?(board) == false
    return false
  end
  if full?(board) == false && won?(board) != false
    return true
  end
  if won?(board) != false && full?(board) == true
    return true
  end
  if draw?(board) == true
    return true
  end
end



#WINNER
def winner(board)
  if won?(board) != false
    array_count = 0
    while array_count <= 7
      win_index_1 = WIN_COMBINATIONS[array_count][0]
      win_index_2 = WIN_COMBINATIONS[array_count][1]
      win_index_3 = WIN_COMBINATIONS[array_count][2]
      position_1 = board[win_index_1] # load the value of the board at win_index_1
      position_2 = board[win_index_2] # load the value of the board at win_index_2
      position_3 = board[win_index_3] # load the value of the board at win_index_3
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return "X"
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return "O"
      else
        array_count = array_count + 1
      end
    end
  end
end
