# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  #horizonal rows
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],

  #vertical rows
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],

  #diagonals
  [0, 4, 8],
  [2, 4, 6]
]

# Helper Method
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

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] &&
    board[win_combination[1]] == board[win_combination[2]] &&
    position_taken?(board, win_combination[0])
  end
end

def full?(board)
  return board.all?{|i| i != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board)
end

def winner(board)
  if won = won?(board)
    board[won[0]]
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
    if won?(board) || draw?(board)
      break
    end
  end

  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    winner = winner(board)
    puts "Congratulations " + winner + "!"
  end
end
