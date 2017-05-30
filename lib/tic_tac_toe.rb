require "pry"

#win combinations constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(input)
  puts " #{input[0]} | #{input[1]} | #{input[2]} \n-----------\n #{input[3]} | #{input[4]} | #{input[5]} \n-----------\n #{input[6]} | #{input[7]} | #{input[8]} \n"
end

def input_to_index(user_input)
  index = user_input.to_i
  index -= 1
  return index
end

def move(arr, index, val)
  arr[index] = val
  # return arr
end

# def position_taken?(board, index)
#   !(board[index].nil? || board[index] == " ")
# end

def position_taken?(arr, index)
  arr[index] == "X" || arr[index] == "O"
end

def valid_move?(arr, index)
  !position_taken?(arr, index) && index.between?(0, 8)
end

def turn_count(arr)
  turns_taken = 0
  arr.each do |x|
    if x == "X" || x == "O"
      turns_taken += 1
    end
  end
  return turns_taken
end

def current_player(arr)
  turn_tally = turn_count(arr)

  if turn_tally % 2 == 0
    # puts "It is now X's turn"
    return "X"
  else
    # puts "It is now O's turn"
    return "O"
  end
end

def won?(arr)
  WIN_COMBINATIONS.detect do |x|

    win_index_1 = x[0]
    win_index_2 = x[1]
    win_index_3 = x[2]

    position_1 = arr[win_index_1]
    position_2 = arr[win_index_2]
    position_3 = arr[win_index_3]

    position_taken?(arr, win_index_1) && position_taken?(arr, win_index_2) && position_taken?(arr, win_index_3) && position_1 == position_2 && position_2 == position_3

    # if position_taken?(arr, win_index_1) && position_taken?(arr, win_index_2) && position_taken?(arr, win_index_3)
    #   if position_1 == position_2 && position_2 == position_3
        # binding.pry
        # return x
    #   end
    # end

  end
end

def full?(arr)

  arr.all? do |x|
    x == "X" || x == "O"
  end

  # counter = 0
  #
  # arr.each do |x|
  #   if ( x == "X" || x == "O" )
  #     counter += 1
  #   end
  # end
  # if counter == 9
  #   return true
  # else
  #   return false
  # end
end

def draw?(arr)
  full?(arr) && !won?(arr)
end

def over?(arr)
  # returns true if the board has been won, is a draw, or is full
  won?(arr) || full?(arr)
end

def winner(arr)
  binding.pry
  if win_arr = won?(arr)
  arr[win_arr[0]]
  end
end

# ask for input
# get input
# convert input to index
# if move is valid
#   make the move for index and show board
# else
#   ask for input again until you get a valid move
# end

def turn(arr)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(arr, index)
    token = current_player(arr)
    move(arr, index, token)
    display_board(arr)
  else
    puts "Invalid move! Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
end

def play(arr)
  # until over?(arr)
  #     turn(arr)
  #   end
  while !over?(arr)
    # binding.pry
    turn(arr)
  end

  if won?(arr)
    win_token = winner(arr)
    puts "Congratulations #{win_token}!"
  elsif draw?(arr)
    puts "Cats Game!"
  end
end
