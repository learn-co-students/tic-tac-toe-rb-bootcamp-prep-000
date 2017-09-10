WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6],  # left column
  [1,4,7], # middle column
  [2,5,8],  # right column
  [0,4,8], # diagonal one
  [2,4,6]  # diagonal two
]

def display_board(board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, index)
  if board[index] == " "
    false
  elsif board[index] == "X" || board[index] == "O"
    true
  end
end

def valid_move?(board, index)
  taken = position_taken?(board, index)

  if index.between?(0,8) && !taken
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  position = input_to_index(input)
  valid = valid_move?(board, position)
  if !valid
    turn(board)
  else
    character = current_player(board)
    move(board,position,character)
    display_board(board)
  end
end

def turn_count(board)
  counter = 0

  board.each do |index|
    if index == "X" || index == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_array|
    all_items = win_array.all? do |index|
      position_taken?(board, index) && board[index] == "X"
    end
    if all_items
      return win_array
    else
      all_items = win_array.all? do |index|
        position_taken?(board, index) && board[index] == "O"
    end
    if all_items
      return win_array
    end
   end
  end
   return false
end

def full?(board)
  index = [0,1,2,3,4,5,6,7,8]
  index.all? { |index| position_taken?(board, index) }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    array = won?(board)
    return board[array[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if over?(board) && won?(board)
    puts "Congratulations " + winner(board) + "!"
  elsif over?(board) && draw?(board)
    puts "Cat's Game!"
  end
end
