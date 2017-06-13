WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  [0, 3, 6], # left column
  [1, 4, 7], # middle column
  [2, 5, 8], # right column
  [0, 4, 8], # left diagonal
  [2, 4, 6]  # right diagonal
]
board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]

def display_board(board)
  print " #{board[0]} " "|" " #{board[1]} " "|" " #{board[2]} " "\n"
  print                      "-----------"                      "\n"
  print " #{board[3]} " "|" " #{board[4]} " "|" " #{board[5]} " "\n"
  print                      "-----------"                      "\n"
  print " #{board[6]} " "|" " #{board[7]} " "|" " #{board[8]} " "\n"
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, input, current_player)
  return board[input] = current_player
end

def position_taken?(board, index)
  return (board[index] == " " || board[index] == '' || board[index] == nil) ? false : true
end

def valid_move?(board, index)
  return (!position_taken?(board, index) && index.between?(0,8)) ? true : false
end

def turn(board)
  puts "Please enter a number between 1-9"
  user_input = gets.strip

  index = input_to_index(user_input)

  if (valid_move?(board, index))
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count #interger
end

def current_player(board)
  (turn_count(board).even?) ?  "X" :   "O"
end

def won?(board)
  win_combo = []
  won = false

  WIN_COMBINATIONS.each do |combo|
    combo.each do |i|
      win_combo.push(board[i])
    end
    if (win_combo.all? { |i| i == "X"} || (win_combo.all? { |i| i=="O"}))
      return combo
    else
      win_combo = []
    end
  end
  return won
end

def full?(board)
  board.none?{ |i| i == " "}
end

def draw?(board)
  full?(board) && !won?(board) ? true : false
end

def over?(board)
  if (full?(board) || (won?(board) != false) || draw?(board))
     return true
  end
 end

def winner(board)
  winner = nil
  combo = []

  if(over?(board) && won?(board))
    combo = won?(board)
    winner = board[combo[0]]
  end
  return winner
end


def play(board)
  until over?(board) do
    turn(board)
    display_board(board)
  end

  if draw?(board)
    puts "Cats Game!"
    else
    puts "Congratulations #{winner(board)}!"
  end
end
