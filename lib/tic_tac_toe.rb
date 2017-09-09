# $board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
# winning_combo = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
# $turn_count = 1
# $play_again = true
#
# def valid_move?(index)
#   index.between?(0,8) && !position_taken?(index)
# end
#
# def position_taken?(location)
#   $board[location] == "X" || $board[location] == "O"
# end
#
# def display_board(winning_combo)
#   puts " "
#   puts "Turn = #{$turn_count}"
#   puts " #{$board[0]} | #{$board[1]} | #{$board[2]}  |  1 | 2 | 3"
#   puts "----------- | -----------"
#   puts " #{$board[3]} | #{$board[4]} | #{$board[5]}  |  4 | 5 | 6"
#   puts "----------- | -----------"
#   puts " #{$board[6]} | #{$board[7]} | #{$board[8]}  |  7 | 8 | 9"
# end
#
# def input_to_index(user_input)
#   user_input.to_i - 1
# end
#
# def currentPlayer
#   return $turn_count % 2 != 0 ? "X" : "O"
# end
#
# def win?(winning_combo)
#   winning_combo.any? do |combo|
#     combo.all? do |i|
#       $board[i] == currentPlayer
#     end
#   end
# end
#
# def over?(winning_combo)  #controls the play flow
#   return win?(winning_combo) || $turn_count == 10
# end
#
# def move(index, function, winning_combo)
#   $board[index] = function
#   if !over?(winning_combo)
#   $turn_count += 1
#   end
# end
#
# def turn(winning_combo)
#   puts "Player \"#{currentPlayer}\": Please enter 1-9:"
#   input = gets.strip
#   index = input_to_index(input)
#   if valid_move?(index)
#     move(index, currentPlayer, winning_combo)
#     display_board(winning_combo)
#   else
#     turn(winning_combo)
#   end
# end
#
# def play(winning_combo)
#   while !over?(winning_combo)
#     turn(winning_combo)
#   end
# end
#
# def playagain?
# 	puts "Play Again? (y/n)"
#  	selection = gets.strip.downcase
#  		if selection == "y"
#       $play_again = true
#     else
#       $play_again = false
#     end
# end
#
# def reset
#   $board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
#   $turn_count = 1
# end
#
# def outputWinner(winning_combo)
#   if win?(winning_combo)
#       puts "Player #{$turn_count % 2 != 0 ? "X" : "O"} Wins!"
#   end
#   if $turn_count == 10
#       puts "The game ended in a draw?"
#   end
# end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  board[index]== "X" || board[index] == "O"
  # Creates a stop on RSpec
  # !(board[location].nil? || board[location] == "")
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def move(board, index, player)
  board[index] = player
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end
