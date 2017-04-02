
#require 'pry'

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

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def valid_move?(board, index)
  if (index.between?(0, 8) && position_taken?(board, index) == false)
    true
  else
    false
  end
end

def position_taken?(board, index)
  if (board[index] == " " || board[index] == "")
    false
  elsif (board[index] == "X" || board[index] == "O")
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  until valid_move?(board, index) == true
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
  end
  #need something to keep track of whose turn it is and replace the "X" with the right one
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  occupied_spaces = 0
  board.each do |space|
    if (space == "X" || space =="O")
      occupied_spaces += 1
    end
  end
  occupied_spaces
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  #loop dat WIN_COMBINATIONS
  WIN_COMBINATIONS.any?{|combo|
    (board[combo[0]] == board[combo[1]]) && (board[combo[1]] == board[combo[2]]) && (board[combo[0]] == "X" || board[combo[0]] == "O")
  }
end

def full?(board)
  board.all? do |space|
    space == "X" || space =="O"
  end
end

def draw?(board)
  if won?(board) == true
    false
  elsif full?(board) == true
    true
  end
end

def over?(board)
  if won?(board) == true
    true
  elsif draw?(board) == true
    true
  end
end

def winner(board)
  def da_winning_combination(board)
    WIN_COMBINATIONS.detect {|combo|
    (board[combo[0]] == board[combo[1]]) && (board[combo[1]] == board[combo[2]]) && (board[combo[0]] == "X" || board[combo[0]] == "O")
  }
#return value is the winning array
  end
  if da_winning_combination(board) == nil
    nil
  else
    board[da_winning_combination(board)[0]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) == true
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end



#def da_winning_combination(board)
  #WIN_COMBINATIONS.detect {|combo|
  #(board[combo[0]] == board[combo[1]]) && (board[combo[1]] == board[combo[2]]) && (board[combo[0]] == "X" || board[combo[0]] == "O")
#}
#end
#pry.start
