#CLI Tic Tac Toe
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
  puts " ----------- "
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts " ----------- "
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def player_move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
   board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  (index.between?(0,8) && !position_taken?(board, index))
end

def turn(board)
  puts "Which space would you like to select: 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player_move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if(space == "X" || space == "O")
      count += 1
    end
  end
  count
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    player = "X"
  else
    player = "O"
  end
  player
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    position_taken?(board, win_combo[0]) &&
    board[win_combo[0]] == board[win_combo[1]] &&
    board[win_combo[1]] == board[win_combo[2]]
  end
end

def full?(board)
  board.all? {|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end