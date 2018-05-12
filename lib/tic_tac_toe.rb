
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
  ]

# Define your WIN_COMBINATIONS constant
# Helper Methods
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

# def position_taken?(board, location)
#   board[location] != " " && board[location] != ""
# end
# Helper Method

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
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
  counter = 0
  board.each do |space| 
    if space == "X" || space == "O"
      counter += 1
    else
      counter += 0
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]  # [0, 1, 2]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    win_index_4 = win_combination[3]
    win_index_5 = win_combination[4]
    win_index_6 = win_combination[5]
    win_index_7 = win_combination[6]
    win_index_8 = win_combination[7]
    
    position_1 = board[0]   # board[0, 1, 2]
    position_2 = board[1]
    position_3 = board[2]
    position_4 = board[3]
    position_5 = board[4]
    position_6 = board[5]
    position_7 = board[6]
    position_8 = board[7]
    position_9 = board[8]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return WIN_COMBINATIONS[0]
    elsif position_4 == "X" && position_5 == "X" && position_6 == "X"
      return WIN_COMBINATIONS[1]
    elsif position_7 == "X" && position_8 == "X" && position_9 == "X"
      return WIN_COMBINATIONS[2]  
    elsif position_1 == "X" && position_5 == "X" && position_9 == "X"
      return WIN_COMBINATIONS[3]
    elsif position_3 == "X" && position_5 == "X" && position_7 == "X"
      return WIN_COMBINATIONS[4]
    elsif position_1 == "X" && position_4 == "X" && position_7 == "X"
      return WIN_COMBINATIONS[5]
    elsif position_2 == "X" && position_5 == "X" && position_8 == "X"
      return WIN_COMBINATIONS[6]
    elsif position_3 == "X" && position_6 == "X" && position_9 == "X"
      return WIN_COMBINATIONS[7]
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return WIN_COMBINATIONS[0]
    elsif position_4 == "O" && position_5 == "O" && position_6 == "O"
      return WIN_COMBINATIONS[1]
    elsif position_7 == "O" && position_8 == "O" && position_9 == "O"
      return WIN_COMBINATIONS[2]  
    elsif position_1 == "O" && position_5 == "O" && position_9 == "O"
      return WIN_COMBINATIONS[3]
    elsif position_3 == "O" && position_5 == "O" && position_7 == "O"
      return WIN_COMBINATIONS[4]
    elsif position_1 == "O" && position_4 == "O" && position_7 == "O"
      return WIN_COMBINATIONS[5]
    elsif position_2 == "O" && position_5 == "O" && position_8 == "O"
      return WIN_COMBINATIONS[6]
    elsif position_3 == "O" && position_6 == "O" && position_9 == "O"
      return WIN_COMBINATIONS[7]
    else
      return false
    end
  end
end

def full?(board)
  !(board.any? { |space| space == " " })
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board)
    return false
  else 
    return false
  end
end

def over?(board)
  if full?(board) 
    return true
  elsif draw?(board)
    return true
  elsif !won?(board) && full?(board)
    return true
  elsif won?(board) && !full?(board)
    return true
  elsif !full?(board) && !won?(board)
    return false
  else
    return false
  end
end

def winner(board)
    position_1 = board[0]   # board[0, 1, 2]
    position_2 = board[1]
    position_3 = board[2]
    position_4 = board[3]
    position_5 = board[4]
    position_6 = board[5]
    position_7 = board[6]
    position_8 = board[7]
    position_9 = board[8]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
    elsif position_4 == "X" && position_5 == "X" && position_6 == "X"
      return "X"
    elsif position_7 == "X" && position_8 == "X" && position_9 == "X"
      return "X"
    elsif position_1 == "X" && position_5 == "X" && position_9 == "X"
      return "X"
    elsif position_3 == "X" && position_5 == "X" && position_7 == "X"
      return "X"
    elsif position_1 == "X" && position_4 == "X" && position_7 == "X"
      return "X"
    elsif position_2 == "X" && position_5 == "X" && position_8 == "X"
      return "X"
    elsif position_3 == "X" && position_6 == "X" && position_9 == "X"
      return "X"
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"
    elsif position_4 == "O" && position_5 == "O" && position_6 == "O"
      return "O"
    elsif position_7 == "O" && position_8 == "O" && position_9 == "O"
      return "O"
    elsif position_1 == "O" && position_5 == "O" && position_9 == "O"
      return "O"
    elsif position_3 == "O" && position_5 == "O" && position_7 == "O"
      return "O"
    elsif position_1 == "O" && position_4 == "O" && position_7 == "O"
      return "O"
    elsif position_2 == "O" && position_5 == "O" && position_8 == "O"
      return "O"
    elsif position_3 == "O" && position_6 == "O" && position_9 == "O"
      return "O"
    else
      return nil
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
