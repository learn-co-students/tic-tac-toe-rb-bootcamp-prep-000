WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # top-right to bottom-left diagonal
  [2,4,6], # top-left to bottom-right diagonal
]

def display_board(board)
  cells = board.collect {|elt| " #{elt} " }
  row_1 = "#{cells[0]}|#{cells[1]}|#{cells[2]}"
  row_2 = "#{cells[3]}|#{cells[4]}|#{cells[5]}"
  row_3 = "#{cells[6]}|#{cells[7]}|#{cells[8]}"
  line = "-" * 11
  puts "#{row_1}\n#{line}\n#{row_2}\n#{line}\n#{row_3}"
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, character)
  board[index] = "#{character}"
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  for square in board
    if ["X", "O"].include? square
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    position_values = [
      board[combo[0]],
      board[combo[1]],
      board[combo[2]]
    ]
    [["X","X","X"], ["O","O","O"]].include? position_values
  end
end

def full?(board)
  board.all? do |position|
    position_taken?(board, board.index(position))
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winning_positions = won?(board)
  won?(board) ? board[winning_positions[0]] : nil
end

def play(board)
  current_turn = 0
  until over?(board)
    current_turn += 1
    turn(board)
  end
  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
