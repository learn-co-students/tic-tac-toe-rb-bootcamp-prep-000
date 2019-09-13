# Define display_board that accepts a board and prints
# out the current state.

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your #valid_move? method here

def valid_move?(board, index)
    if index.between?(0,8) && !position_taken?(board, index)
        true
    else
      false
    end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.

def position_taken?(board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil
      false
  else
    true
  end
end

# code your input_to_index and move method here!

def input_to_index(input)
  index = input.to_i
  index -= 1
  return index
end

def move(board, index, current_player)
  board[index] = current_player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    "please submit a valid input"
    input = gets.strip
  end
end

# Define your play method below

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


def turn_count(board)
  counter = 0
  board.each do |previous_move|
    if (previous_move == "X" || previous_move == "O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if !turn_count(board).odd?
    return "X"
  else
    return "O"
  end
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      return win_combination
    else
      # do nothing
    end
  end
  return nil
end

def full?(board)
  board.none? { |e| e.nil? || e == " "}
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  if over?(board) && !full?(board) && !draw?(board)
    won?(board).each do |item|
      if board[item].include?("X")
      return "X"
    else
      return "O"
    end
  end
end
end
