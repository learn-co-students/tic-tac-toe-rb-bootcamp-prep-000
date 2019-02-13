

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
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

def move(board, index, current_player)
  board[index] = current_player
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

def won?(board)
  WIN_COMBINATIONS.each { |key|
    if key.all? { |index| board[index] == "X" } || key.all? { |index| board[index] == "O" }
      return key
    end
  }
  return false
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def full?(board)
  return !board.find { |square| square != "X" && square != "O"}
end

def draw?(board)
  return (!won?(board) and full?(board))
end

def over?(board)
  return (won?(board) or full?(board))
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def turn_count(board)
  board.select { |space|
    space == "X" || space == "O"
  }.length
end

def current_player(board)
  if turn_count(board).odd?
    "O"
  else
    "X"
  end
end

def play(board)
  while (!over?(board) && !draw?(board))
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
