def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

## Helpers involving input and putting a token down

# Define your play method below
#Accepts a board and starts a loop of #turn
def play(board)
  counter = 0
  while (!over?(board))
    turn(board)
    counter += 1
  end
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

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |spot|
    if (spot == "X" || spot == "O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  player = turn_count(board) % 2
  player == 0 ? "X" : "O"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


####  Winning and completing game Helpers
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

#accept a board as an argument
#returns fales/nil if there is no win
#returns true if someone has won and returns the indexes
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    spot1 = board[combo[0]]
    spot2 = board[combo[1]]
    spot3 = board[combo[2]]
    if (spot1 == "X" || spot1 == "O")
      if (spot1 == spot2 && spot1 == spot3)
        return combo
      end
    end
  end
    return false
end

def full?(board)
  !board.detect{|spot| (spot == " " || spot == "" || spot == nil)}
end

def draw?(board)
  if (full?(board) && !won?(board))
    puts "Cat's Game!"
    return true
  else
    return false
  end
end

def over?(board)
  if (won?(board) || draw?(board))
    winner(board)
    return true
  else
    return false
  end
end

def winner(board)
  combo = won?(board)
  if combo
    player = board[combo[0]]
    puts "Congratulations #{player}!"
    return player
  end
end
