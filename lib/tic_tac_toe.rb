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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  end
  player = current_player(board)
  move(board, index, player)
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each do |space|
    if space == "X" || space == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.any? do |combo|
    (board[combo[0]] == board[combo[1]]) &&
    (board[combo[1]] == board[combo[2]]) &&
    position_taken?(board, combo[0])
  end
end

def winning_combo(board)
  WIN_COMBINATIONS.detect do |combo|
    ((board[combo[0]] == "X")  && (board[combo[1]] == "X") && (board[combo[2]] == "X")) ||
    ((board[combo[0]] == "O")  && (board[combo[1]] == "O") && (board[combo[2]] == "O"))
  end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if won?(board)
    return board[winning_combo(board)[0]]
  end
end


def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
