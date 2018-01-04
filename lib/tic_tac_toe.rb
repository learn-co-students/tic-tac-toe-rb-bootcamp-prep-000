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

def move(board, index, player_token)
  board[index] = player_token
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
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |item|
    if item != " " && item != ""
      counter = counter + 1
    end
  end
  return counter
end

def current_player(board)
  player = "X"
  turns = turn_count(board)
  if turns % 2 == 1
    player = "O"
  end
  return player
end

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
  
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    end
    if board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  return false
end

def full?(board)
  board.all? do |number|
    number != " "
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == TRUE
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return TRUE
  else
    return false
  end
end

def winner(board)
  if won?(board) == false 
    return nil
  else 
    combo = won?(board)
    return board[combo[0]]
  end
end

# Define your play method below
def play(board)
  while over?(board) == false
    turn(board)
  end
  if draw?(board) == TRUE
    puts "Cat's Game!"
  end
  if won?(board) != false
    game_winner = winner(board)
    puts "Congratulations #{game_winner}!"
  end
end