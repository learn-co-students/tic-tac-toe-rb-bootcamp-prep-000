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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  space = (user_input.to_i) - 1
end

def player_move(board, space, character)
  board[space] = character
  return board
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  else
    return false
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  character = current_player(board)
    if valid_move?(board, index)
      player_move(board, index, character)
      display_board(board)
    else
      puts "Invalid Move"
      turn(board)
    end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
    count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2 == 0 
    character = "X"
  else
    character = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |condition|
  win_index_1 = condition[0]
  win_index_2 = condition[1]
  win_index_3 = condition[2]
  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return condition
    end
  end
end

def full?(board)
  board.all? do |square|
    square == "X" || square == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board).class == Array
   board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
