WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Forward diagonal
  [2,4,6]  # Backward diagonal
]

#helper methods

#display_board creates a blank tic tac toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts "-----------"
end

#input_to_index converts a user_input to an integer
def input_to_index(input)
  index = input.to_i - 1
end

#move allows "X" player in the bottom right and "O" in the top left
def move(board, position, player)
  board[position] = "#{player}"
end

#valid_move? returns true/false based on index
def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board,index)
    true
  else
    false
  end
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    true
  else
    false
  end
end

#turn puts everything all together
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board,index)
    move(board, index, player)
    display_board(board)
    return board
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  positions = []
  winner = []
  WIN_COMBINATIONS.each do |winCombo| #iterate over each winning combination of the entire winning combinations array
    counter = 0
    winCombo.each do |index| #iterate over each element of each winning combo
      positions[counter] = board[index] #pushes the element of the current board at the index based off the winning combination element
      counter += 1
    end
    if positions.all? {|position| position == "X"} #if all the board elements in the winning combo indexes are X, it's a win!
      return winCombo
    elsif positions.all? {|position| position == "O"} #same above but for O
      return winCombo
    end
  end
  return false #returns false after the function iterates through each winning combination
end


def full?(board)
  board.none?{|space| space == " "}
end


def draw?(board)
  if full?(board) && !won?(board)
    return true
else
    return false
  end
end


def over?(board)
  if  won?(board) || draw?(board)
    return true
  else
    return false
  end
end


def winner(board)
  if won?(board)
    winCombo = won?(board)
    index = winCombo[0]
    return board[index]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
