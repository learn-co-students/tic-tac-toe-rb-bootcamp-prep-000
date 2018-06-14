# Define your WIN_COMBINATIONS constant
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
	count = 0 
	board.each do |position|
		if position == "X" || position == "O"
			count +=1
		end
	end
	count
end

def current_player(board)
	#current_turn = turn_count(board)
	#if current_turn.even?
	#	return "X"
	#else
	#	return "O"
	#end

	turn_count(board).even? ? "X" : "O"
end

def won?(board)
	WIN_COMBINATIONS.detect do |combo|
		board[combo[0]] == board[combo[1]] &&
		board[combo[1]] == board[combo[2]] &&
		position_taken?(board, combo[0])
	end
end


def full?(board)
	board.all? do |position|
		position != " " && position != ""
	end
end

def draw?(board)
	full?(board) && !won?(board)
end

def over?(board)
	won?(board) || full?(board) || draw?(board)
end

def winner(board)
	if won?(board)
		board[won?(board)[0]]
	end
end