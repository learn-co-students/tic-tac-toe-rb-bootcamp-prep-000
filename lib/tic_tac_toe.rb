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
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  !(board[position] == " " || board[position].nil?)
end

def turn(board)
  puts "Select your move"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def valid_move?(board, position)
  position.between?(0,8) && !position_taken?(board, position)
end

def turn_count(board)
  9 - board.count(" ")
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    row = [board[combo[0]], board[combo[1]], board[combo[2]]]
    return combo if row.uniq.length == 1 && row[0] != " "
  end
  false
end

def full?(board)
  board.count(" ") == 0
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  won?(board) ? board[won?(board).first] : nil
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
