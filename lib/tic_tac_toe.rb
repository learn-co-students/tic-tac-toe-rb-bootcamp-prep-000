
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts  " #{board[0]} | #{board[1]} | #{board[2]} "
  puts  "-----------"
  puts  " #{board[3]} | #{board[4]} | #{board[5]} "
  puts  "-----------"
  puts  " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
 index = input.to_i - 1
end


def move(board, index, character)
  board[index] = character
end


def valid_move?(board, index)
    if index.between?(0,8) && !position_taken?(board,index)
      true
    end
end


def position_taken?(board, index)
  if board[index] == " " || board[index] == ""
    return false
  else
    return true
  end
end


def turn(board)
  character = "X"
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end


def play(board)
  until over?(board)
    turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else turn_count(board) % 2 == 1
    "O"
  end
end


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

def won?(board)
  WIN_COMBINATIONS.detect do |winc|
    board[winc[0]] == board[winc[1]] &&
    board[winc[1]] == board[winc[2]] &&
    (board[winc[0]] == "X" || board[winc[0]] == "O")
  end
end


def full?(board)
  board.all? do |fullb|
    fullb == "X" || fullb == "O"
  end
end


def draw?(board)
  (!won?(board) && full?(board))
end


def over?(board)
  (won?(board) || draw?(board))
end


def winner(board)
  if WIN_COMBINATIONS.detect do |winc|
    board[winc[0]] == board[winc[1]] &&
    board[winc[1]] == board[winc[2]] &&
    board[winc[0]] == "X"
    end
    "X"
  elsif WIN_COMBINATIONS.detect do |winc|
    board[winc[0]] == board[winc[1]] &&
    board[winc[1]] == board[winc[2]] &&
    board[winc[0]] == "O"
    end
    "O"
  else
    nil
  end
end
