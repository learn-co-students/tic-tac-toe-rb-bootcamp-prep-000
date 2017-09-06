
WIN_COMBINATIONS = [
  [0,1,2], # Top row
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

def turn_count(arr)
  counter = 0
  arr.each do |element|
    if element == "O" ||element == "X"
      counter += 1
    end
    end
    counter
end

def current_player(arr)
  if turn_count(arr) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo| # win_combo is same as WIN_COMBINATIONS[0][1][2]
    if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]]== "X") || (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
     return win_combo
    end
    end
    return false
end

def full?(arr)
  arr.all? do |element|
    element == "X" || element == "O"
end
end

def draw?(arr)
  !won?(arr) && full?(arr)
end

def over?(game)
  won?(game) || draw?(game)
end

def winner(board)
  # we have game which will be the board array
  # won?(game) will be either false, or an array (for example: [0,1,2])
  # we can't grab a value of an index for false
  if won?(board)
     board[won?(board)[0]]
  end
end


def play(board)
  
  until over?(board)
    turn(board)
  end
    #move(current_player(board), input_to_index())
  if won?(board)
    puts("Congratulations #{winner(board)}!")
  elsif draw?(board)
  puts("Cat's Game!")
end
end
