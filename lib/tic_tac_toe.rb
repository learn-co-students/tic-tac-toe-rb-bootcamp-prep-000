# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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
  top_row_win = WIN_COMBINATIONS[0]
  middle_row_win = WIN_COMBINATIONS[1]
  bottom_row_win = WIN_COMBINATIONS[2]
  left_column_win = WIN_COMBINATIONS[3]
  middle_column_win = WIN_COMBINATIONS[4]
  right_column_win = WIN_COMBINATIONS[5]
  left_diagonal_win = WIN_COMBINATIONS[6]
  right_diagonal_win = WIN_COMBINATIONS[7]
  if (top_row_win.all? {|x| board[x] == "X"} || top_row_win.all? {|x| board[x] == "O"})
    top_row_win
  elsif (middle_row_win.all? {|x| board[x] == "X"} || middle_row_win.all? {|x| board[x] == "O"})
    middle_row_win
  elsif (bottom_row_win.all? {|x| board[x] == "X"} || bottom_row_win.all? {|x| board[x] == "O"})
    bottom_row_win
  elsif (left_column_win.all? {|x| board[x] == "X"} || left_column_win.all? {|x| board[x] == "O"})
    left_column_win
  elsif (middle_column_win.all? {|x| board[x] == "X"} || middle_column_win.all? {|x| board[x] == "O"})
    middle_column_win
  elsif (right_column_win.all? {|x| board[x] == "X"} || right_column_win.all? {|x| board[x] == "O"})
    right_column_win
  elsif (left_diagonal_win.all? {|x| board[x] == "X"} || left_diagonal_win.all? {|x| board[x] == "O"})
    left_diagonal_win
  elsif (right_diagonal_win.all? {|x| board[x] == "X"} || right_diagonal_win.all? {|x| board[x] == "O"})
    right_diagonal_win
  end
end 

def full? (board)
  if (board.all? {|x| x != " "})
    true
  else
    false
  end
end

def draw? (board)
  if (full?(board) == true)
    if (!won?(board))
      true
    else
      false 
    end
  end
end

def over? (board)
  if (draw?(board) || won?(board))
    true
  else
    false 
  end
end

def winner(board)
  if (won?(board))
    if (board[won?(board)[0]] == "X")
      "X"
    elsif (board[won?(board)[0]] == "O")
      "O"
    else
      nil
    end
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  input.to_i-1
end

def move (board, index, value)
  board[index] = value
end

# code your #valid_move? method here
def valid_move?(board, index)
  index = index.to_i
  # return (index.between?(0,8) && !position_taken?(board, index))
  if (index.between?(0, 8))
    if (position_taken?(board, index))
      false
    else
      true
    end
  else
    false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken? (board, position)
  if (board[position] == "X" || board[position] == "O")
    return true
  else
    return false
  end
end

def turn(board)
  index = nil
  loop do
    puts "Please enter 1-9:"
    input = gets.strip
    index = input.to_i-1 #input_to_index(input)
    break if (valid_move?(board, index))
  end
  move(board, index, "X")
  display_board(board)
end

# Define your play method below
def play(board)
  turns = 0 
  while turns < 9 
    turn(board)
    turns += 1
  end
end

def turn_count (board)
  board.select {|x| x != " "}.length
end

def current_player (board)
  if(turn_count(board).even?)
    "X"
  else
    "O"
  end
end