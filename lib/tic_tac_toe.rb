#Tic Tac Toe!!!
WIN_COMBINATIONS =
[
  [0,1,2],[3,4,5],[6,7,8], # win by horizontal row
  [0,3,6],[1,4,7],[2,5,8], # win by vertical column
  [0,4,8],[2,4,6]          # win by diagonal
]

def play(board)
  current_turn = 1
  while current_turn <= 9
    if over?(board); break; end;
    turn(board)
    current_turn += 1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
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

def move(board, index, current_player)
  board[index] = current_player
end

def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 1
    "O"
  else
    "X"
  end
end

def turn_count(board)
  count = 0
  board.each { |position| if position == "X" || position == "O"; count+=1; end }
  count
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    all_x = combo.all? do |index|
      board[index] == "X"
    end
    all_o = combo.all? do |index|
      board[index] == "O"
    end
    if all_x || all_o
      return combo
    end
  end
  false
end

def full?(board)
  result = board.all? do |position|
    position == "X" || position == "O"
  end
  result
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  false
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  end
  false
end

def winner(board)
  win = won?(board)
  if win
    return board[win[0]]
  end
  nil
end
