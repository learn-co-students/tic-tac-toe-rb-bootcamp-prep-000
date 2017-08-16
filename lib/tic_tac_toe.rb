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
  column_count = 3
  row_count = board.count / column_count

  row_count.times do |row_idx|
    offset = row_idx * row_count
    puts " #{board[offset]} | #{board[offset + 1]} | #{board[offset + 2]} "
    puts "-" * (column_count * 4 - 1) unless row_idx == row_count - 1
  end
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  index.between?(0, board.count - 1) && !position_taken?(board, index)
end

def turn_count(board)
  board.select { |token| token != " " }.count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    position_taken?(board, combo[0]) &&
      board[combo[0]] == board[combo[1]] &&
      board[combo[1]] == board[combo[2]]
  end
end

def full?(board)
  board.none? { |token| token == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board)
end

def winner(board)
  winning_combo = won?(board)
  board[winning_combo.first] if winning_combo
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    current_player = current_player(board)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  display_board(board)
  until over?(board) || draw?(board)
    turn(board)
  end

  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cats Game!" if draw?(board)
end
