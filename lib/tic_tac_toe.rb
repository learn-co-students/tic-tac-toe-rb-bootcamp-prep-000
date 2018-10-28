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

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=
[
  [0,1,2], #top row [0]
  [3,4,5], #middle row [1]
  [6,7,8], #bottom row [2]
  [0,4,8], #diagonal left to right [3]
  [2,4,6], #diagonal right to left [4]
  [0,3,6], #left column [5]
  [1,4,7], #middle column [6]
  [2,5,8]  #right column [7]
]

def turn(board)
  puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    m = valid_move?(board, index)
  if m == true
    character = current_player(board)
    move(board, index, character)
  else m == nil
    puts "Sorry, that was an invalid move. Please enter 1-9:"
    display_board(board)
    # turn(board)
    input = gets.strip
    index = input_to_index(input)
    m = valid_move?(board, index)
  end
end


 def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    end
  end
  return counter
end
 def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.detect do |win_indexes_array|
    index_one=win_indexes_array[0]
    index_two=win_indexes_array[1]
    index_three=win_indexes_array[2]
      if board[index_one]=="X" && board[index_two]=="X" && board[index_three]=="X"
      return win_indexes_array
      elsif board[index_one]=="O" && board[index_two]=="O" && board[index_three]=="O"
      return win_indexes_array
      else
          false
    end
  end
end



def full?(board)
  board.all? do |x|
    if x=="X" || x=="O"
      true
    else
      false
    end
  end
end



def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end



def over?(board)
  if draw?(board)
    true
  elsif won?(board) && full?(board)
    true
  elsif won?(board) && !full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != nil
    winner = board[won?(board)[0]]
  end
end

def play(board)
until over?(board) == true
  turn(board)
end
if draw?(board) == true
  puts "Cat's Game!"
else won?(board)
  puts "Congratulations #{winner(board)}!"
end
end
