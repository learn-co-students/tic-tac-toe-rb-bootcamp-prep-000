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

def move(board, index, curr_player)
  board[index] = curr_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    curr_player = current_player(board)
    move(board, index, curr_player)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def turn_count(board)
  count = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      count += 1
    end
  end
  count
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5],
  [6,7,8],
  [0,3,6], #first col
  [1,4,7],
  [2,5,8],
  [0,4,8], #diag
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if ((board[combination[0]] == board[combination[1]]) && (board[combination[1]] == board[combination[2]]) && (board[combination[0]] != " "))
      return combination
    end
  end
  return false
end

def full?(board)
  if board.any? { |pos| pos == " "}
    false
  else
    true
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo.kind_of?(Array)
    return board[winning_combo[0]]
  end
  nil
end
