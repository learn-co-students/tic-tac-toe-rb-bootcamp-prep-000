# helper methods

WIN_COMBINATIONS = [
  # row combos
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],

  # col combos
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],

  # diag combos
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
  !(board[index] == " " || board[index] == "" || board[index] == nil)
end

def valid_move?(board, index)
  (!position_taken?(board, index)) && index.between?(0, 8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if(valid_move?(board, index))
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    puts "Invalid move. Please try again."
    turn(board)
  end
end

def turn_count(board)
  count = 0

  board.each do |turn|
    if (turn == "X" || turn == "O")
      count += 1
    end
  end

  return count
end

def current_player(board)
  count = turn_count(board) + 2
  (count % 2 == 0) ? "X" : "O"
end

def won?(board)
  win = false

  WIN_COMBINATIONS.each do |win_combo|
    all_x = win_combo.all? {|pos| board[pos] == "X"}
    all_o = win_combo.all? {|pos| board[pos] == "O"}

    if (all_x || all_o)
      win = win_combo
    end
  end

  return win
end

def full?(board)
  board.all? {|pos| pos == "X" || pos == "O"}
end

def draw?(board)
  draw = false

  if full?(board)
    if !(won?(board))
      draw = true
    end
  end

  return draw
end

def over?(board)
  over = false

  if full?(board) || won?(board) || draw?(board)
    over = true
  end

  return over
end

def winner(board)
  token = nil

  if won?(board)
    win_combo = won?(board)
    token = board[win_combo[0]]
  end

  return token
end

# play method

def play(board)
  until (over?(board))
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end
end
