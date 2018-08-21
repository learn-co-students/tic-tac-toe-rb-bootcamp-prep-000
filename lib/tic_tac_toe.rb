WIN_COMBINATIONS = [
  [0, 1, 2], # Top row 
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
  [0, 4, 8], # Left diagonal
  [2, 4, 6]  # Right diagonal 
]

def display_board(board)
  puts <<-BOARD
 #{board[0]} | #{board[1]} | #{board[2]} 
-----------
 #{board[3]} | #{board[4]} | #{board[5]} 
-----------
 #{board[6]} | #{board[7]} | #{board[8]} 
BOARD
end

def blank?(something)
  something.nil? || something.strip.empty?
end

def input_to_index(input)
  input.to_i - 1 
end 

def move(board, i, player)
  board[i] = player
  board
end

def position_taken?(board, index)
  !blank?(board[index])
end

def valid_move?(board, index)
  index.to_i.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  player = current_player(board) 
  i = input_to_index(input)
  if valid_move?(board, i)
    move(board, i, player)
    display_board(board)
  else
    puts "Please enter another input"
    turn(board)
  end
end

def turn_count(board)
  # board.reduce(0) do |total, cell|
  #   blank?(cell) ? total : total + 1
  # end
  # board.reject { |cell| blank? cell }.length
  board.count { |cell| !blank? cell }
end 

def current_player(board) 
  if turn_count(board).even? 
    "X"
  else 
    "O"
  end 
end

def won?(board)
  WIN_COMBINATIONS.detect do |i, j, k|
    positions = [i, j, k].map { |p| board[p] }
    position_taken?(board, i) && positions.all? { |p| p == positions[0] }
  end
end

def full?(board) 
  board.all? { |position| !blank?(position) }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  win = won?(board)
  board[win[0]] if win
end

def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else 
    puts "Cat's Game!"
  end
end