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

####display

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

####logic

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#def valid_move?(board, move)
#  index = move - 1
#
#  index >= 0 && index < 9 && !position_taken?(board, index)
#end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

### tests
def input_to_index(user_input)
  user_input.to_i - 1
end

####checks

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] &&
    board[win_combo[1]] == board[win_combo[2]] &&
    position_taken?(board, win_combo[0]) #for case: " "
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}

  #above from solutions, why not this:
  #board.all? do |field|
  #  field == "X" || flied == "0"
  #end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) #draw?(board) not necessary
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo[0]]
  end
end

####moves

def move(board, index, player)
  board[index] = player
  display_board(board)
end

def turn(board)
  player = current_player(board)
  puts "Please make your move (#{player}, 1 - 9)"

  move = gets.strip.to_i
  if valid_move?(board, move - 1)
    move(board, move - 1, player)
  else
    puts "Go again:"
    turn(board)
  end
end

#def turn_count(board)
#  counter = 0
#  board.each do |field|
#    if field == "X" || field == "0"
#       counter++
#    end
#  end
#end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

#def current_player(board)
#  if turn_count(board) % 2 == 0
#    turn = "0"
#  else
#    turn = "X"
#  end
#  return turn
#end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

####play

def play(board)
  while !won?(board) && !full?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congrats #{winner}! You got three in a row"
  elsif draw?
    puts "It's a draw!"
  end
end
