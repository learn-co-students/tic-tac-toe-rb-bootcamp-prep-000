
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

def input_to_index(input)
  input.to_i - 1
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
	  player_token = current_player(board)
	  if valid_move?(board, index)
	    move(board, index, player_token)
	    display_board(board)
	  else
	    turn(board)
	  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
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
  WIN_COMBINATIONS.each do |combo|
	if  board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" ||
      board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
	  return combo
	end
  end
  	return false
end

def full?(board)
  if board.detect {|i| i == "" || i == " "}
    return false
  else
    return true
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    p "GAME OVER!"
    return true
  end
end

def winner(board)
  if won?(board) == false
    return nil
  end
	var = board[won?(board)[0]]
  if var == "X"
	  return "X"
  end
  if var == "O"
    return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end
