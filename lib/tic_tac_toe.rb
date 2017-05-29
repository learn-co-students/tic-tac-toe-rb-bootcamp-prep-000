board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(user_input)
  user_int = user_input.to_i-1
end

def move(board, board_index, char)
  board[board_index] = char
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  char = current_player(board)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |index_value|
    if (index_value != " ")
      counter += 1
    end
  end
  counter
end

def current_player(board)
  player = turn_count(board)
  if (player.even?)
    "X"
  else
    "O"
  end
end

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
  #empty_draw = false
  WIN_COMBINATIONS.detect do |combo|
    if (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[0]))
      return combo
    end
  end
#  empty_draw
end

def full?(board)
  board.none? {|i| i == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if (won?(board))
    array = won?(board)
    board[array[0]]
  else nil
  end
end
