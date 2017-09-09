def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  if index.between?(0,9) && !position_taken?(board,index)
    return true
  else
    return false
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def move(board, pos, char)
  return board[pos] = char
end

def input_to_index(input)
  return input.to_i - 1
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

def turn_count(board)
  turn_num = 0
  board.each do |space|
    if space != " " && space != ""
      turn_num += 1
    end
  end
  return turn_num
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end


# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  # Row
  [0,1,2],
  [3,4,5],
  [6,7,8],
  # Col
  [0,3,6],
  [1,4,7],
  [2,5,8],
  # Diagonal
  [0,4,8],
  [2,6,4]
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_x = win_combination.all? do |win_index|
      (board[win_index] == "X")
    end
    win_o = win_combination.all? do |win_index|
      (board[win_index] == "O")
    end
    if win_x || win_o
      return win_combination
    end
  end
  return false # should not be reached unless all win combinations not present
end

def full?(board)
  [0,1,2,3,4,5,6,7,8].all? do |place|
    position_taken?(board, place)
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  won?(board) || draw?(board) ||  full?(board) ? true : false
end

def winner(board)
  win_indexes = won?(board)
  if win_indexes == false
    return nil
  else
    return board[win_indexes[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
