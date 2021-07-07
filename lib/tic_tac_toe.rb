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

def input_to_index(input)
 	inp = nil
 	if input.kind_of?(Array)
 		inp = input.join.to_i
 	else 
 		inp = input.to_i
 	end
 	i = inp - 1
 	return i
 end

 def move(array, index, char)
 	array[index] = char
 	return array
 end

 def position_taken?(array, char)
	if array[char] == "" || array[char] == " " || array[char].nil?
		return false
	else array[char] == "X" || array[char] == "O"
		return true
	end
end

def valid_move?(array, i)
	if !position_taken?(array, i) && i.between?(0, 8)
		true
	else
		false
	end
end

def turn(array)
	puts "Please enter 1-9:"
	input = gets.split
	i = input_to_index(input)
	if valid_move?(array, i)
		move(array, i, current_player(array))
		display_board(array)
	else
		puts "invalid"
		new_i = gets.split
	end
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
	count = turn_count(board)
	count % 2 == 0 ? "X" : "O"
end


def won?(board)
	WIN_COMBINATIONS.each do |combo|
		arr = []
		for i in combo
			arr.push(board[i])
			if arr == ["X","X","X"] || arr == ["O","O","O"]
				return combo
			end
		end
	end
	return false
end

def full?(board)
	for i in board
		if i == " " || i == ""
			return false
		end
	end
	true
end

def draw?(board)
	if !won?(board) && full?(board)
		return true
	end
	false
end

def over?(board)
	if full?(board) || won?(board) || draw?(board)
		# binding.pry
		return true
	end
	return false
end

def winner(board)
	combo = won?(board)
	if won?(board)
		for i in combo
			return board[i]
		end
	end
end

def play(board)
  	counter = 0
  	until counter == 9 || over?(board)
    	turn(board)
    	counter += 1
    	end
    	if over?(board) && won?(board)
    		puts "Congratulations #{winner(board)}!"
    	end
    	if over?(board) && draw?(board)
    		puts "Cat's Game!"
    	end
  	end
