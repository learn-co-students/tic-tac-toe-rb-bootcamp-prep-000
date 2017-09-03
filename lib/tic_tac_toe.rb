
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
  index
end

def move(board, index, char)
  board[index] = char
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn_count(board)
  moves = board.select { |i| i == "X" || i == "O" }
  moves.length
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  valid_move?(board, index) ? move(board, index, current_player(board)) : turn(board)
  display_board(board)
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

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|

      board[win_combination[0]] == board[win_combination[1]] &&
      board[win_combination[1]] == board[win_combination[2]] &&
      position_taken?(board, win_combination[0])

 end
end

def full?(board)
  !board.detect { |i| i == " " || i == "" }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    winningIndex = won?(board)[0]
    board[winningIndex]
  end
end
