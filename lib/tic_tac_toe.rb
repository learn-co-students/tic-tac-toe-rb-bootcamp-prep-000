WIN_COMBINATIONS = [
# Rows
  [0,1,2],
  [3,4,5],
  [6,7,8],
# Columns
  [0,3,6],
  [1,4,7],
  [2,5,8],
# Diagionals
  [0,4,8],
  [2,4,6],
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if !(position_taken?(board, index)) && index.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
  else
    turn(board)
  end
  puts display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |item|
    if item == "X" || item == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_0 = win_combination[0]
    win_index_1 = win_combination[1]
    win_index_2 = win_combination[2]

    position_0 = board[win_index_0]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]

    if position_0 == position_1 && position_1 == position_2 && position_taken?(board, win_index_0)
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.none? {|index| index == nil || index == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  win_combination = won?(board)
  if win_combination
    win_location = win_combination[0]
    return board[win_location]
  end
end

def play(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
