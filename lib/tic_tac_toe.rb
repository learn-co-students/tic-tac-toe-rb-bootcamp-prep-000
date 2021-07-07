require 'pry'
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #topleft to botright diag
  [2, 4, 6] #topright to botleft diag
]
 def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
 def input_to_index(input)
  input = input.to_i
  if input.between?(1,9)
    input -= 1
  else
    input = -1
  end
end
 def move(board, index, current_player)

  board[index] = current_player
end
 def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end
 def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
 def turn(board)
  player = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    until valid_move?(board, index)
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
    end
    move(board, index, player)
    display_board(board)
  end
end
 def turn_count(board)
  turns = 0
  board.each do |position|
    if position == "X" || position == "O"
      turns += 1
    end
  end
  return turns
end
 def current_player(board)
  if turn_count(board) % 2 == 0
    token = "X"
  else
    token = "O"
  end
end
 def won?(board)
  WIN_COMBINATIONS.each do |combo|
    position_1 = board[combo[0]]
    position_2 = board[combo[1]]
    position_3 = board[combo[2]]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") or (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combo
    end
  end
  false
end
 def full?(board)
  board.none?{|i| i==" "}
end
 def draw?(board)
  if full?(board) and !won?(board)
    true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  end
end
 def winner(board)
  if won?(board)
    winning_row = won?(board)
    board[winning_row[0]]
  end
end
 def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end
end
