def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Back slash diagonal
  [2,4,6]  # Forward slash diagonal
]

def won?(board)
  winner = nil
  WIN_COMBINATIONS.any? do |combination|
    value = board[combination[0]]
    winner = combination if position_taken?(board, combination[0]) && combination.all?{|position| board[position] == value}
  end
  winner
end

def full?(board)
  board.all?{|cell| cell == "X" || cell == "O"}
end

def draw?(board)
  !won?(board) && full?(board) 
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  winning_combination = won?(board)
  winning_combination.nil? ? nil : board[winning_combination[0]] 
end

def turn_count(board)
  counter = 0
  board.each{|cell| counter += 1 if cell == "X" || cell == "O"}
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  loop do
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      break
    end
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  
  w = winner(board)
  puts w.nil? ? "Cat's Game!" : "Congratulations #{w}!"
end

