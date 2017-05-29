
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #first column
  [1,4,7], #middle column
  [2,5,8], #third column
  [0,4,8], #negative diagonal
  [6,4,2] #positive diagonal
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


def input_to_index(user_input)
  user_input.to_i - 1
end


def move(board, index, player)
  board[index] = player
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
  current_turn = 0
  board.each do |space|
    if space == "X" || space == "O"
      current_turn += 1
    end
  end
  current_turn
end


def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[1])
  end
end


def full?(board)
  board.all? { |space| space == "X" || space == "O" }
end


def draw?(board)
  !won?(board) && full?(board)
end


def over?(board)
  won?(board) || draw?(board)
end


def winner(board)
  if the_winner = won?(board)
   board[the_winner.first]
  end
end
