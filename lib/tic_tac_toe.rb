
def display_board(board)
  3.times do |i|
    j = i * 3
    puts " #{board[j]} | #{board[j+1]} | #{board[j+2]} "
    if i < 2
      puts "-----------"
    end
  end
end

def input_to_index(input)
  input.to_i - 1
end

def player_move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  cell = board[index]
  cell != " " && cell != "" && cell != nil
end

def valid_move?(board, index)
  if not index.between?(0, board.length-1)
    return false
  end
  not position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
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
  counter = 0
  board.each do |item|
    counter += (" " == item) ? 0 : 1
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # First diagonal
  [2,4,6]  # Second diagonal
]

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[0]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? { |e| e == "X" || e == "O" }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  (win_combo = won?(board)) ? board[win_combo[0]] : nil
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if gamer = winner(board)
    puts "Congratulations #{gamer}!"
  else
    puts "Cat's Game!"
  end
end
