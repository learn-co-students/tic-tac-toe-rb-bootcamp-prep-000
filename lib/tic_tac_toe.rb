
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Right Diagonal
  [2,4,6]  # Left Diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index] == " " || board[index] == "")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = board.select do |index|
    !(index == " " || index == "")
  end
  count.length
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def won?(board)
  i = 0
  x_moves = []
  o_moves = []
  board.each do |token|
    if token == "X"
      x_moves << i
    elsif token == "O"
      o_moves << i
    end
    i += 1
  end

  winners = false
  WIN_COMBINATIONS.each do |combos|
    if combos.all? {|combo| x_moves.include?(combo)}
      winners = combos
      # winners << combos[0]
      # winners << combos[1]
      # winners << combos[2]
    elsif combos.all? {|combo| o_moves.include?(combo)}
      winners = combos
    end
  end
    return winners
end

def full?(board)
  !(board.include?("") || board.include?(" "))
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  index = won?(board)
  if index
    board[index[0]]
  else
    nil
  end
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
