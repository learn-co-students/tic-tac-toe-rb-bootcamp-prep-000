WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  player = current_player(board)
  puts "Make your move by entering a number from 1 to 9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, player)
    puts board
  else
    puts "Make your move by entering a number from 1 to 9"
    input = gets.strip
  end
end

def turn_count(board)
  count = 0
  board.each do |v|
    if v == "X" || v == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def won?(board)
  x_indices = []
  o_indices = []
  win_status = false

  board.each_index do |i|
    x_indices << i if board[i] == "X"
    o_indices << i if board[i] == "O"
  end


 WIN_COMBINATIONS.each do |combination|
    win_status = combination if x_indices & combination == combination
    win_status = combination if o_indices & combination == combination
  end
  win_status
end

def full?(board)
  board.none?{|space| space === " "} && !won?(board)
end

def draw?(board)
  full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winning_indices = won?(board)
  winner = won?(board) ? board[winning_indices[0]] : nil
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
