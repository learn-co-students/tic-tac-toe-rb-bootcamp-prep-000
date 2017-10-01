def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

# Define won?, full?, draw?, over?, and winner below
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end


def input_to_index(input)
  index = input.to_i - 1
  return index
end

def move(board, position, token)
  board[position] = token
end

def valid_move?(board, position)
  position.between?(0,8) && !(position_taken?(board, position))
end

def turn(board)
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index) == true
    move(board,index,current_player(board))
  else
    turn(board)
  end

end

def turn_count(board)
  count = 0
  board.each do |token|
    if token == "X" || token == "O"
      count+=1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def play(board)
  counter = 0
  until counter == 8
    if !(over?(board))
      turn(board)
      if draw?(board)
        break
      end
      counter+= 1
    else
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      end
      break
    end
  end

  if draw?(board)
    puts "Cat's Game!"
  end
end
