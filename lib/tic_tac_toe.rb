require "pry"

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #mid row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left col
  [1, 4, 7], #mid col
  [2, 5, 8], #right col
  [0, 4, 8], #\ diag
  [2, 4, 6] #/ diag
]

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, location)
  if board[location] != " " && board[location] != ""
    return true
  else
    return false
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
while !over?(board)
  turn(board)
end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " "
      counter += 1
    end
  end
  counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
    current = "X"
  else
    current = "O"
  end
  current
end

def won?(board)
  WIN_COMBINATIONS.detect do |combination| ## Find and RETURN first element (which will be an array) within WIN_COMBINATIONS that matches following conditions:
    board[combination[0]] == board[combination[1]] && ## board index corresponding to first index of |combination| equals second index of board index corresponding to second index of |combination|
    board[combination[1]] == board[combination[2]] && ## second index corresponding to second index of |combination| equals third index of board index corresponding to third index of |combination|
    position_taken?(board, combination[0]) ## first board index corresponding to first index of |combination| is not blank or nil
  end
end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board) #For some reason the spec test only passes if won(board) is called first
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if winning_player = won?(board) ## sets variable <winning_player> to the array output of #won? IF such a variable is allowed to exist (is true). Else, returns nil
  board[winning_player[0]]
  end
end
