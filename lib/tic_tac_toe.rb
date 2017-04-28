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

def play(board)
	until over?(board)
		turn(board)
	end
	if won?(board)
		winner = winner(board)
		puts "Congratulations #{winner}!"
	elsif draw?(board)
		puts "Cats Game!"
	end
end

def won?(board)
	WIN_COMBINATIONS.each do |combo|
		if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
		 	return combo
		end
	end
		WIN_COMBINATIONS.each do |combo|
		if board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
		 	return combo
		end
	end
	return false 
end

def full?(board)
	board.all? do |spot|
		spot.include?("X") == true || spot.include?("O") == true
	end
end

def draw?(board)
	if won?(board)
		return false
	end
	if full?(board)
		return true
	end
end

def over?(board)
	if draw?(board)
		return true
	end
	if won?(board)
		return true
	end
	return false
end

def winner(board)
	if over?(board) == false
		return nil
	end
	WIN_COMBINATIONS.each do |combo|
		if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
		 	return "X"
		end
	end
	WIN_COMBINATIONS.each do |combo|
		if board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
		 	return "O"
		end
	end
end

def turn_count(board)
	counter = 0
	board.each do |spot|
		if spot == "X"
			counter += 1
		elsif spot == "O"
			counter += 1
		end	
	end
	return counter
end

def current_player(board)
turns = turn_count(board)	
	if turns.even?
		return "X"
	end
	return "O"
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(str)
  int = str.to_i
    if int == 0
      return -1
    end
  return int - 1
end

def move(board, position, current_player)
  board[position] = current_player
  return board
end

def valid_move?(board, input)
  index = input 
  if index > 8 || index < 0
    return false
  end
position_taken?(board, index) == false
end

def position_taken?(board, index)
  if board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  else
    return true
  end
end

def turn(board)
  current_player = current_player(board)
  puts " #{current_player}, Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
   if valid_move?(board, index) == false
      puts "invalid"
      turn(board)
   end
  move(board, index, current_player)
  display_board(board)
end

