WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (input)
  index = input.to_i - 1
end

def move (board, index, character)
  board[index] = character
end

def position_taken? (board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move? (board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn (board)
  puts "Please enter 1 to 9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count (board)
  board.count { |i| i == "X" || i == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.detect do |win_element|
    position_taken?(board, win_element[0]) &&
    board[win_element[0]] == board[win_element[1]] &&
    board[win_element[1]] == board[win_element[2]]
  end
end

def full?(board)
  board.all? { |i| i == "X" || i == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
    if won?(board)
      win_element = won?(board)
      board[win_element.first]
    end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
