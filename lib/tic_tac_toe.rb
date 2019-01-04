require 'pry'
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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player) # does not allow for a default third argument (FAILED - 1)
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
  x = 0
  o = 0

  board.each do |token|
    if token == "X"
      x += 1
    elsif token == "O"
      o +=1
    end
  end
  x + o
end

def current_player(board)
   count = turn_count(board)
  # if count.even?
  #   "X"
  # else
  #   "O"
  # end

  count.even? ? "X" : "O" # ternary
end

def won?(board)
#won_array = [] # user .each for iteration.
  WIN_COMBINATIONS.find do |combination|
    if position_taken?(board, combination[0]) && position_taken?(board, combination[1]) && position_taken?(board, combination[2]) && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
      won_array = combination
    end
  end
  #won_array
end #end of method

def full?(board)
  board.find.with_index do |position, index|
    if position_taken?(board, index) == false
      return  false
    end
  end
  return true
end #end of method

def draw?(board)
  !won?(board) && !full?(board) != true
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

#main method:

def play(board)
  while !over?(board)
    turn(board)
    #current_player = current_player(board)

  #binding.pry
  end


  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end

end
