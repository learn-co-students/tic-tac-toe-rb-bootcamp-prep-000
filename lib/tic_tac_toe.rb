# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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

def move(board, index, current_player)
  board[index] = current_player
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
    move(board, index, current_player(board) )
    display_board(board)
  else
    turn(board)
  end
end

# Things to build
def turn_count(board)
  turn = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      turn += 1
    end
  end
  turn
end


#CURRENT_PLAYER
# The #current_player method should take in an argument of the game board and use the #turn_count method to determine if it is "X"'s turn or "O"'s.

def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
end
# Define your play method below

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
      puts "Cats Game!"
  elsif won?(board)
      puts "Congratulations #{winner(board)}!"
  end
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  # Horizonal wins
  [0,1,2],
  [3,4,5],
  [6,7,8],
  # Vertical wins
  [0,3,6],
  [1,4,7],
  [2,5,8],
  # Diagonal wins
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.none? {|i| i == " " }
end

def draw?(board)
  full?(board) &! won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end
