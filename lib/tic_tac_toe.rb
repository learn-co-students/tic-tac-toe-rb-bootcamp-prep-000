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

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    position_taken?(board, win_combination[0]) && ( board[win_combination[0]] == board[win_combination[1]] && board[win_combination[0]] == board[win_combination[2]] )
  end
end

def full?(board)
  board.all? do |i|
    !(i == " " || i == nil)
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  if !valid_move?(board, index)
    turn(board)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def turn_count(board)
  board.count{|token| token=="X" || token == "O"}
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def move(board, index, character)
  board[index] = character
end

def input_to_index(user_input = -1)
  user_input.to_i - 1
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end
