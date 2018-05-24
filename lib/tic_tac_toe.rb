WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(input)
num = input.to_i - 1
end

def move(array, index, value)
array[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move? (board, index)
  if position_taken?(board, index)
    return FALSE
  elsif !(index.between?(0, 8))
    return FALSE
  else
    return TRUE
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 9
  board.each do |space|
    if space == " "
      counter -= 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else
    return "O"
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
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      FALSE
    end
  end
  return FALSE
end

def full?(board)
  if board.select{|i| i == " "} == []
    TRUE
  else
    FALSE
  end
end

def draw?(board)
  if full?(board)
    if won?(board)
      FALSE
    else
      TRUE
    end
  else
    FALSE
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    TRUE
  else
    FALSE
  end
end

def winner(board)
  if won?(board)
    winning_combination = won?(board)
    if board[winning_combination[0]] == "X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end
end

def play(board)
  until over?(board)
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