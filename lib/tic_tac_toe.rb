# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  index = input.to_i - 1
end

def move(board, position, char)
  board = update_array_at_with(board, position, char)
end

def update_array_at_with(array, index, value)
  array[index] = value
end

# code your #position_taken? method here!
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] = "X" || board[index] == "O"
    true
  end
end

# code your #valid_move? method here
def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    true
  elsif position_taken?(board, index)
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |move|
    if (move == "X" || move == "O")
      count += 1
    end
  end

  return count
end

def current_player(board)
  if (turn_count(board).odd?)
    return "O"
  else
    return "X"
  end
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == position_2 && position_2 == position_3  && position_1 != " " && position_2 != " " && position_3 != " ")
      return win_combination
    end
  end

  return false

end

def full?(board)
  board.detect do |index|
    if(index == " ")
      return false
    end
  end

  return true
end

def draw?(board)
  if !(won?(board))
    if (full?(board))
      return true
    else
      return false
    end
  else
    return false
  end
end

def over?(board)
  if (won?(board) || draw?(board) || full?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if !(won?(board))
    return nil
  else
    win_combination = won?(board)
    return board[win_combination[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if (won?(board))
    if (winner(board) == "X")
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  elsif (draw?(board))
    puts "Cats Game!"
  end

end
