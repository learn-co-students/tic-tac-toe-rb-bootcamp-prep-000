WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  line = "-----------"
  board = [row1, line, row2, line, row3]

  puts board
end

def input_to_index(input)
  input.to_i - 1
end

def valid_move?(board, index)
  if !position_taken?(board, index) && on_board?(index)
    true
  else
    false
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def on_board?(index)
  if index.between?(0, 8)
    true
  else
    false
  end
end

def move(board, index, value)
  board[index] = value
  board
end

def turn_count(board)
  counter = 0
  board.each do |square|
    if square != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end
# NEED TO FIX TURN THIS IS MY IMPLEMENTATION NOT WHAT THEY ARE LOOKING FOR
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "That move was not vaild please try again"
    turn(board)
  end
end

def won?(board)
  has_won = false
  WIN_COMBINATIONS.each do |combo|
    combo_string = ""
    combo.each do |index|
      combo_string += board[index]
    end
    if combo_string == "XXX" || combo_string == "OOO"
      has_won = combo
    end
  end
  has_won
end

def full?(board)
  full = true
  board.each_with_index do |square, index|
    if valid_move?(board, index)
      full = false
    end
  end
  full
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  winstring = nil
  if won?(board)
    if board[won?(board)[0]] == "X"
      winstring = "X"
    elsif board[won?(board)[0]] == "O"
      winstring = "O"
    end
  end
  winstring
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
