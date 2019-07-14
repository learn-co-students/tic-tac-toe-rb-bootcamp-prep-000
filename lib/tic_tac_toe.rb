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

# Display board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# input to index
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

def turn_count(board)
  board.count { |i| i == "X" || i == "O" }
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else "O"
  end
end

def won?(board)
  won_check = false
    WIN_COMBINATIONS.each do |combination|
      first_index = combination[0]
      second_index = combination[1]
      third_index = combination[2]

      position_1 = board[first_index]
      position_2 = board[second_index]
      position_3 = board[third_index]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X" ) ||
         (position_1 == "O" && position_2 == "O" && position_3 == "O" )
          return combination
          won_check = true
      end
    end
  won_check
end

def full?(board)
  board.none?{|i| i == " "}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  end
end

def over?(board)
  if won?(board) != false || full?(board) == true || draw?(board) == true
    true
  end
end

def winner(board)
  if won?(board) != false
    board[won?(board)[0]]
  end
end

# Define your play method below
def play(board)
 until over?(board) == true do
    turn(board)
  end

  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end

# Helper Method
#def position_taken?(board, index)
#  !(board[index].nil? || board[index] == " ")
#end
