def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  input = input.to_i
  input = input - 1
end

def move(array,index,character)
  array[index] = character
end

def position_taken?(array, index)
  if (array[index] == " ") || (array[index] == "" || (array[index] == nil))
    return false
  else
    return true
  end
end

def valid_move?(array, index)
  if (index >= 0 && array[index] == " ")
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    char = current_player(board)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |turn|
    if turn == 'X' || turn == 'O'
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn = turn_count(board) + 1
  turn % 2 != 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]
    if (board[win_index_1] == 'X' && board[win_index_2] == 'X' && board[win_index_3] == 'X') ||
      (board[win_index_1] == 'O' && board[win_index_2] == 'O' && board[win_index_3] == 'O')
      return combo
    end
  end
  return false
end

def full?(board)
  full = [0,1,2,3,4,5,6,7,8]
  check = full.all? do |index|
    position_taken?(board,index)
  end
  return check
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  elsif !full?(board) && !won?(board)
    return false
  elsif won?(board)
    return false
  end
end

def over?(board)
  if (draw?(board) || won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if (over?(board) && !draw?(board))
    winpos = won?(board)
    return board[winpos[0]]
  else
    return nil
  end
end

def play(board)
  until (over?(board))
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) == 'X'
    puts "Congratulations X!"
  elsif winner(board) == 'O'
    puts "Congratulations O!"
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
