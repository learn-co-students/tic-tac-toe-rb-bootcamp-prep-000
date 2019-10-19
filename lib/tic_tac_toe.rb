# Define your WIN_COMBINATIONS constant
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  update_array_at_with(board, index, value)
end

# code your #valid_move? method here
def valid_move?(board, index)
  if position_taken?(board, index) == false and index.between?(0,8)
    true
  else
    false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.

def position_taken?(board, index)
  if board[index] == " " or board[index] == "" or board[index] == nil
    false
  elsif board[index] == "X" or board[index] == "O"
    true
  end
end

def update_array_at_with(array, index, value)
  array[index] = value
end  
  
def won? (board)
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? {|value| board[value] == "X"}
      return win_combination
    elsif win_combination.all? {|value| board[value] == "O"}
      return win_combination
    else
      false
    end
  end
  return false
end

def full? (board)
  board.all? {|value| value != " "} ? true : false
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over? (board)
  if won?(board) or draw?(board) or full?(board)
    true
  else 
    false
  end
end

#Takes a users num and the board, and places the X or O char in that position
def move(board, index, character)
  board[index] = character
  return board
end

#Asks user for a number, check if it is valid, and if it's not, recursively continues to ask for a number
def turn(board)
  puts "Please enter 1-9:"
  num = gets.chomp
  index = input_to_index(num)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |value|
    if value  != " "
      counter += 1
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

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    return board[winning_combo[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end