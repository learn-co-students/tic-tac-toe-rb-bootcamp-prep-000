WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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
  number_of_turns_played = 0
  
  board.each do |ele|
    if ele == "X" || ele == "O"
      number_of_turns_played += 1
    end
  end
  
  return number_of_turns_played
end

def current_player(board)
  # if turn_count(board) % 2 == 0
  #   return "X"
  # else
  #   return "O"
  # end
 turn_count(board) % 2 == 0 ? "X":"O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if combo.all? { |index| board[index] == "X"}
      return combo
    elsif combo.all? { |index| board[index] == "O"}
      return combo
    end
  end
  return false
end

def full?(board)
  board.each do |ele|
    if ele == " "
      return false
    end
  end
  return true
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  
  return false
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  if isWinner = won?(board)
    return board[isWinner[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end
