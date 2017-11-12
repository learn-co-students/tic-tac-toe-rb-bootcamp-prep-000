
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
#note that a constant in Ruby, simply starts with a capital letter.
WIN_COMBINATIONS =
  [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8], #bottom row
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    # ETC, an array for each win combination
  ]


  def won?(board)
  #8 winning combinations we can access each at WIN_COMBINATIONS[0] - WIN_COMBINATIONS[7]
  i=0
  8.times do

    if board.count == 0
      return false
    end

  if board[WIN_COMBINATIONS[i][0]] == board[WIN_COMBINATIONS[i][1]] && board[WIN_COMBINATIONS[i][1]] == board [WIN_COMBINATIONS[i][2]] &&
    board[WIN_COMBINATIONS[i][0]] != " "


    return WIN_COMBINATIONS[i]

  end

  i+=1

  end

  return false

  end


  def full?(board)
    i = 0
    9.times do
      if board[i] == " "
        return false
      end
      i+=1
    end
    return true
  end


  def draw?(board)

    if won?(board) != false
      return false
    end

    if full?(board) == true
       return true
    end
  end




def over?(board)
  if draw?(board) == true
    return true
  end

if full?(board) && won?(board)
  return true
end

if won?(board)
  return true
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
  user_input.to_i - 1
end

def move(board, index, current_playa)
  board[index] = current_playa
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end






def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end

end


def winner(board)
  if won?(board)
  return board[won?(board)[0]]
else
  return nil
end

end


def turn_count(board)
  i = 0
  turns = 0
  9.times do


if board[i] == "X" || board[i] == "O"
turns +=1
end

  i+=1
end
  return turns


end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
  turn(board)
  end

end


def play(board)

until over?(board) == true
turn(board)

end
if won?(board)
  puts "winner!"
  puts "Congratulations #{winner(board)}!"
  end


  if draw?(board)
    puts "Cat's Game!"
  end


end
