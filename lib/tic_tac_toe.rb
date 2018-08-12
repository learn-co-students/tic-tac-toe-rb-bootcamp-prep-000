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
  sep = "|"
  lines = "-----------"
  puts " #{board[0]} #{sep} #{board[1]} #{sep} #{board[2]} "
  puts "#{lines}"
  puts " #{board[3]} #{sep} #{board[4]} #{sep} #{board[5]} "
  puts "#{lines}"
  puts " #{board[6]} #{sep} #{board[7]} #{sep} #{board[8]} "
end


def input_to_index(val)
  return val.to_i - 1
end


def move(board, index, char)
  board[index] = char
  return board
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  if (board[index] == " ") && (index >= 0) && (index <= 8)
    true
  end
end


def turn(board)
  # Asking the user for their move by position 1-9.
  puts "Please enter 1-9:"
  # Receiving the user input.
  input = gets
  # Convert position to an index.
  index = input_to_index(input)
  # If the move is valid, make the move and display the board to the user.
  if valid_move?(board, index)
    char = current_player(board)
    move(board, index, char)
  # If the move is invalid, ask for a new move until a valid move is received.
  else
    puts "Invalid entry! Try again..."
    turn(board)
  end
  display_board(board)
end


def turn_count(board)
  moves = 0
  board.each do |space|
    if (space == "X" || space == "O")
      moves += 1
    end
  end
  return moves
end


def current_player(board)
  moves = turn_count(board)
  # if (moves % 2 == 0)
  #   return "X"
  # elsif (moves % 2 == 1)
  #   return "O"
  # end
  player = (moves % 2 == 0) ? "X" : "O"
end


def won?(board)
  players = ["X", "O"]
  players.each do |player|
    WIN_COMBINATIONS.any? do |combo|
      if (board[combo[0]] == player) && (board[combo[1]] == player) && (board[combo[2]] == player)
        return combo
      end
    end
  end
  return false
end

def full?(board)
  board.none?{|piece| piece == " "}
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  end
end

def over?(board)
  if (draw?(board) || full?(board) || won?(board))
    true
  end
end

def winner(board)
  pieces = won?(board)
  if pieces
    board[pieces[0]]
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
