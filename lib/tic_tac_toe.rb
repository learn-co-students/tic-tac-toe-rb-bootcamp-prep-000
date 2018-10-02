WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [6, 4, 2], #bottom-left to top-right diagonal
  [0, 4, 8] #top-left to bottom-right diagonal
  ]
  
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

def move(board, index, token)
  board[index] = token
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
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_number = 0
  board.each do |token|
    if (token == "X" || token == "O")
      turn_number += 1
    end
  end
  return turn_number
end

def current_player(board)
  turn_number = turn_count(board)
  turn_number.even? ? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.detect do |i|
      win_index_1 = i[0]
      win_index_2 = i[1]
      win_index_3 = i[2]
      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
      ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
    end
end
  
def full?(board)
    board.all? do |i|
       i == "X" || i == "O"
    end
end

def draw?(board)
  if full?(board)
    if !(won?(board))
      return true
    else
      return false
    end
  else
    return false
  end
end
  
def over?(board)
  draw?(board) || won?(board)
end
  
def winner(board)
  if (won?(board))
    winning_array = won?(board)
    return board[winning_array[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board) do
  turn (board)
  end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cat's Game!"
end
end

  
  

  
  





