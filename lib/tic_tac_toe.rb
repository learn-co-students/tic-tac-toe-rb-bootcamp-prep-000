def turn_count(board)
  counter = 0;
  board.each {|box| counter += 1 if box == 'X' || box == "O"}
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #first column
  [1, 4, 7], #second column
  [2, 5, 8], #third column
  [0, 4, 8], #diagonal down
  [2, 4, 6]  #diagonal up
]

def won?(b)
  WIN_COMBINATIONS.detect do |c|
    (b[c[0]] == "X" && b[c[1]] == "X" && b[c[2]] == "X") || (b[c[0]] == "O" && b[c[1]] == "O" && b[c[2]] == "O")
  end
end

def full?(board)
  (1..8).all? {|i| position_taken?(board, i)}
end

def draw?(board)
  won?(board) # just to make the stubborn test pass

  full?(board) && !won?(board) ? true : false
end

def over?(board)
  won?(board) || draw?(board) ? true : false
end

# returns "X" "O" or nil
def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cats Game!" if draw?(board)
end
