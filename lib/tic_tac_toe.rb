#WIN_COMBINATIONS
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

#PLAY
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

#DISPLAY_BOARD
def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#VALID_MOVE? +
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#WON +
def won?(board)
  WIN_COMBINATIONS.detect do |index|
      board[index[0]] == board[index[1]] &&
      board[index[1]] == board[index[2]] &&
      position_taken?(board, index[0])
  end
end

#FULL +
def full?(board)
  board.all?{|index| index == "X" || index == "O"}
end

#DRAW +
def draw?(board)
  !won?(board) && full?(board)
end

#OVER +
def over?(board)
  won?(board) || draw?(board)
end

#INPUT_TO_INDEX +
def input_to_index(user_input)
  user_input.to_i - 1
end

#TURN +
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

#POSITION_TAKEN? +
def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

#CURRENT_PLAYER +
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"

#  if turn_count(board) % 2 == 0
#    "X"
#  else
#    "O"
#  end
end

#TURN_COUNT +
def turn_count(board)

  board.count{|token| token == "X" || token == "O"}

#  turns = 0
#  board.each do |value|
#    if value == "X" || value == "O"
#      turns +=1
#    end
#  end

end

#MOVE +
def move(board, index, character)
  board[index] = character
end

#WINNER +
def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end
