# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [2, 4, 6],
  [0, 3, 6], [1, 4, 7], [2, 5, 8]]

def won?(board)
  WIN_COMBINATIONS.each do |line|
    combo = []
    line.each do |index|
      combo << board[index]
    end

    all_x = combo.all? do |spot|
      spot == "X"
    end

    all_o = combo.all? do |spot|
      spot == "O"
    end

    if all_x == true || all_o == true
      return line
    end

  end
  false
end

def full?(board)
  board.none? do |position|
    position == " "
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  false
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
  false
end

def winner(board)
  if won?(board)
    winning_line = won?(board)
    return board[winning_line[0]]
  end
  nil
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

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

def valid_move?(board, index)
  if position_taken?(board, index) || !index.between?(0, 9)
    return false
  end
  true
end

def move(board, position, token)
    board[position] = token
end

def turn_count(board)
  turn = 0
  board.each do |space|
    if space == "O" || space == "X"
      turn += 1
    end
  end
  turn
end

def current_player(board)
  symbol =  turn_count(board).even? ? "X" : "O"
end

def turn(board)
  symbol = current_player(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  position = input_to_index(input)
  if valid_move?(board, position)
    move(board, position, symbol)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
