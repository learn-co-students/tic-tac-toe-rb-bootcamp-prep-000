WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def move(board, index, value)
  board[index] = value
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end



def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")
      return win_combination
    else
      false
    end
  end
  return false
end


def full?(board)
  board.each do |space|
    if space == " " || space == "" || space == nil
      return false
    end
  end
  return true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if !won?(board)
    return nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  else
    return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end