require "pry"

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[2, 4, 6],
[0, 4, 8]
]

def won?(board)

  WIN_COMBINATIONS.find do |combination|
    board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] && position_taken?(board, combination[0])
  end
end

def full?(board)
  !board.include?(" ")
end


def draw?(board)
   !won?(board) && full?(board)
end

def over?(board)
won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def turn_count(board)
  turn_number = 0
  board.each do |counter|
    if counter == "X" || counter == "O"
      turn_number += 1
    end
  end
  turn_number
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def valid_move?(board, index)
 index.between?(0,8) && !position_taken?(board,index)
end


def turn(board)
 puts "Please enter 1-9:"
user_move = gets.strip
user_index = input_to_index(user_move)
validity = valid_move?(board, user_index)
if validity
  move(board, user_index, current_player(board))
  display_board(board)
else
  turn(board)
end
end

def move(board, index, token)
  board[index] = token
end

def input_to_index(user_input)
  input_int = user_input.to_i
  index = input_int - 1
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
if position_taken?(board, index) == true
  return false
elsif index.between?(0,8) == false
  return false
elsif index.between?(0,8) == true && position_taken?(board,index) == false
  return true
end
end

def play(board)
puts "Welcome to Tic Tac Toe!"
while !over?(board)
      turn(board)
    end
if won?(board)
  puts "Congratulations #{winner(board)}!"

elsif draw?(board) == true
  puts "Cat's Game!"
end
end
