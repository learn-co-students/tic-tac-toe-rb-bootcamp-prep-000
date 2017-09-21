WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]# ETC, an array for each win combination
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, position, char)
  board[position] = char
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index < 0 || index > 8
    return false
  else
    if position_taken?(board, index) == false
      return true
    else
      return false
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  while valid_move?(board, index) == false
    puts "Please enter 1-9:"
    user_input = gets.chomp
    user_input.to_i
    index = input_to_index(user_input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  if counter == 0 || counter % 2 == 0
    return player = "X"
  else
    return player = "O"
  end
end

def won?(board)
  if board == [" "," "," "," "," "," "," "," "," "]
    return false
  else
    winner = WIN_COMBINATIONS.each do |combinations|
      win_index_1 = combinations[0]
      win_index_2 = combinations[1]
      win_index_3 = combinations[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return combinations
      else
        false
      end
    end
    if winner == false
      false
    end
  end
end

def full?(board)
  available = board.any?{| cells | cells == " "}
  if available != true
    true
  else
    false
  end
end

def draw?(board)
  full = full?(board)
  won = won?(board)
  if (full == true) && (won.is_a?(Array) == true)
    false
  elsif (full == false)
    false
  else
    true
  end
end

def over?(board)
  draw = draw?(board)
  won = won?(board)
  if draw == true || (won.is_a?(Array) == true)
    true
  else
    false
  end
end

def winner(board)
  won = won?(board)
  if won.is_a?(Array) == true
    if board[won[0]] == "X"
      return "X"
    elsif board[won[0]] == "O"
      return "O"
    end
  else
    return nil
  end
end

def play(board)
  win_statement = "Congratulations "
  display_board(board)
  while over?(board) == false
     turn(board)
  end
  if winner(board) == "X"
    puts win_statement + "X!"
  elsif winner(board) == "O"
    puts win_statement + "O!"
  else
    puts "Cat's Game!"
  end
end

#play([" "," "," "," "," "," "," "," "," "])
