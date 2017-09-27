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

def valid_move?(board, move)
  index = move - 1

  index >= 0 && index < 9 && !position_taken(board, index)
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

####moves

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo[0]]
  end
end

def move(board, move, player)

end

def turn
  puts "Please make your move (X, 1 - 9)"

  move = gets.strip
  if valid_move?(move)
    move(board, move - 1, "X")
  else
    turn
  end
end

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

def valid_move?(board, move)
  index = move - 1

  index >= 0 && index < 9 && !position_taken(board, index)
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

####moves

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo[0]]
  end
end

def move(board, move, player)

end

def turn
  puts "Please make your move (X, 1 - 9)"

  move = gets.strip
  if valid_move?(move)
    move(board, move - 1, "X")
  else
    turn
  end
end

#def turn_count(board)
#  counter = 0
#  board.each do |field|
#    if field == "X" || field == "0"
#      counter++
#    end
#  end
#  return counter
#end

def current_player(board)
  turn = ""
  if turn_count(board) % 2 == 0
    turn = "0"
  else
    turn = "X"
  end
end
