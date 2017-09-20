
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #left diagonal
  [2,4,6] #right diagonal
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, user_input, character)
  board[user_input] = character
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
if valid_move?(board, index)
  move(board, index, current_player(board))
  display_board(board)
else
  turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |cell|
  if cell == "X" || cell == "O"
  counter += 1
end
end
  counter
end

def current_player(board)
if turn_count(board) % 2 == 0
  "X"
else
  "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo| # win_combo will be [0,1,2]
    # board[0] is the token in the top left
    # board[1] is the token in the top middle
    # board[2] is the token in the top right
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    position_1 == position_2 && position_1 == position_3 && position_1 != " "
  end
end

def full?(board)
  # all? and there's none?
  board.all?{|token| token != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    win_combo = won?(board) # example value [0,1,2]
    win_index_1 = win_combo[0]
    board[win_index_1]
  end
end

def play(board)

  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
