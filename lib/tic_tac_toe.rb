require 'pry'

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [6, 4, 2],
  [0, 4, 8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts " ----------- "
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts " ----------- "
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  board[position] == "X" || board[position] == "O"
end

def valid_move?(board, position)
  position.between?(0, 8) && !position_taken?(board, position)
end


def turn(board)
  puts "Choose a spot between 1-9"
  spot = gets.strip
  spot = input_to_index(spot)
  if valid_move?(board, spot)
    move(board, spot, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  taken = 0
  board.each do |i|
    if i == "X" || i == "O"
      taken += 1
    end
  end
  return taken
end

def current_player(board)
  player = nil
  if turn_count(board) % 2 == 0
    player = 'X'
  else
    player = 'O'
  end
  return player
end


def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  turn_count(board) == 9
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  won = ""
  if winner = won?(board)
    won = board[winner.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
