WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
  return index
end

def move(board_array, input_index, character)
  board_array[input_index]= character
  return board_array
end

def position_taken?(array, token_index)
  if array[token_index] == " " || array[token_index] == "" || array[token_index] == nil
    return false
  elsif array[token_index] == "X" || array[token_index] == "O"
    return true
  end
end

def valid_move?(array, user_input)
  y = user_input
  if y >= 0 && y <= 8
    if !(position_taken?(array, y))
      return true
    end
  end
end

def turn(array)
  puts "Please enter 1-9:"
  input_by_user = gets.strip
  index = input_to_index(input_by_user)
  if valid_move?(array, index)
    character = current_player(array)
    move(array, index, character)
    display_board(array)
  else
    puts "Invalid move. Please enter 1-9:"
    turn(array)
  end
end

def turn_count(array)
  counter = 0
  array.each do |item|
    if item == "X" || item == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(array)
  counts = turn_count(array)
  if counts == 0 || ((counts % 2) == 0)
    return "X"
  else
    return "O"
  end
end

def won?(array)
  WIN_COMBINATIONS.detect do |win_combination|
    num_1 = win_combination[0]
    num_2 = win_combination[1]
    num_3 = win_combination[2]
    pos_1 = array[num_1]
    pos_2 = array[num_2]
    pos_3 = array[num_3]
    if pos_1 == pos_2 && pos_2 == pos_3 && position_taken?(array, num_1)
      return win_combination
    else
     false
    end
  end
end


def full?(array)
  array.all? do |space|
    if space == " "
      false
    else
      true
    end
  end
end

def draw?(array)
  if full?(array) && !(won?(array))
    true
  else
    false
  end
end
  
def over?(array)
  if draw?(array) || won?(array)
    true
  else
    false
  end
end

def winner(array)
  WIN_COMBINATIONS.detect do |win_combination|
    num_1 = win_combination[0]
    num_2 = win_combination[1]
    num_3 = win_combination[2]
    pos_1 = array[num_1]
    pos_2 = array[num_2]
    pos_3 = array[num_3]
    if pos_1 == pos_2 && pos_2 == pos_3 && position_taken?(array, num_1)
      return pos_1
    else
     false
    end
  end
end

def play(board)
  while !(over?(board))
    turn(board)
  end
  if won?(board)
    token = winner(board)
    puts "Congratulations #{token}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
  end
end