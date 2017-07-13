
require "pry"

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8], #not working
  [2,4,6],
  [0,3,6], # not working
  [1,4,7], #not workng
  [2,5,8] #not working
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

def move(board, position, token)
  board[position] = token
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn === "X" || turn === "O"
      counter += 1
    end
  end
  counter
end


def current_player(board)
turn_count(board).even? ? "X" : "O"
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
  if (valid_move?(board, index))
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def full?(board)
  board.none? { |e| e === " "  }
end

def draw?(board)
  win =
  won?(board)
  full = full?(board)
  if (win === nil && full === true)

    true
  else false
  end
end

def over?(board)
  # win = won?(board)
  # || full?(board) === true   removed from if below...not needed? draw covers this
  if(won?(board)  || draw?(board))
    true
  else false
  end
end

def winner(board)
  moves = won?(board)
  if moves === nil
    nil
  else board[moves[0]]
  end
end

def won?(board)

    WIN_COMBINATIONS.detect do |combo|
      board[combo[0]] !=" " && board[combo[0]] === board[combo[1]] && board[combo[0]] === board[combo[2]]
    end
end


def play(board)

puts "Welcome to Tic Tac Toe"
display_board(board)

until (over?(board) === true)
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
end
if draw?(board)
  puts "Cats Game!"
end

end
