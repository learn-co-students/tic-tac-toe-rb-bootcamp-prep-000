# Helper Method

board1 = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #top column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #top left diagonal
  [2, 4, 6], #top right diagonal
]

def won? (board)
  #if board contains any win combo return true
  #iterate through board
  #won = false
  WIN_COMBINATIONS.each do |winPos|
  #  puts(" Win Position 1: #{winPos[0]} Position 2: #{winPos[1]} Win Position 3: #{winPos[2]}")
    if board[winPos[0]] == "X" && board[winPos[1]] == "X" && board[winPos[2]] == "X"
      return winPos
    end
    if board[winPos[0]] == "O" && board[winPos[1]] == "O" && board[winPos[2]] == "O"
      return winPos
    end
  end
  return false
end

def full?(board)
  board.all? do |section|
    section == "X" || section == "O"
  end
end

def draw?(board)
  if full?(board)
    if won?(board) == false
      return true
    end
  end
  return false
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    winningBoard = won?(board)
    #puts("winning board is #{winningBoard}")
    if board[winningBoard[0]] == "X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end
end

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

def move(board, index, currPlayer)
  board[index] = currPlayer
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  currLetter = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, currLetter)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
#def play(board)
#  turn_num = 0
#  while turn_num < 9
#    turn(board)
#    turn_num += 1
#  end
#end

def turn_count(board)
  counter = 0
  board.each do |currPos|
    if currPos == "X" || currPos == "O"
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

#def play(board)
#  until over?(board) do
#    turn(board)
#    puts "Gameboard: #{board}"
#    if over?(board)
#      if won?(board)
#        puts "Congratulations #{winner(board)}!"
#        return
#      end
#      if draw?(board)
#        puts "Cat's Game!"
#        return
#      end
#    end
#  end
#end
#play(board1)
def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end 
end
