# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right column
  [0,4,8], # Diagonal 1
  [2,4,6]  # Diagonal 2
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_to_int = user_input.to_i
  user_index = user_to_int - 1
end

def move(board, index, var)
  board[index] = var.to_s
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == ""
    return false
  elsif board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8)
    if board[index] == " " || board[index] == "" || board[index] == nil
      return true
    else
      return false
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.to_i
  user_index = input_to_index(user_input)
  if user_index.between?(0, 8)
    if valid_move?(board, user_index)
      board[user_index] = current_player(board)
      display_board(board)
    else
      puts "Sorry, that spot is taken!"
      turn(board)
    end
  else
    puts "That is not a valid choice. Please try again:"
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |letter|
    if letter == "X" || letter == "O"
      count += 1
    else
      count += 0
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def draw?(board)
  if full?(board)
    if !won?(board)
      return true
    end
  else
    return false
  end
end

def won?(board)
  board_test = board.all?{|letter| letter == "" or letter == " "}
  if board_test
    return false
  else
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
    end
    return false
  end
end

def full?(board)
  full_board = 0
  board.each do |letter|
    if letter == "X" || letter == "O"
      full_board += 1
    else
      full_board += 0
    end
  end
  if full_board == 9
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    board_index = won?(board)[0]
    if board[board_index] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until over?(board) || full?(board)
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
end
