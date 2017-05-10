
WIN_COMBINATIONS = [
	#horizontal
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],

	#vertical
	[0, 3, 6],
	[1, 4, 7],
	[2, 5, 8],

	#diagonal
	[0, 4, 8],
	[6, 4, 2]
]


def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(input)
  n = input.to_i
  index = n - 1
end

def move(board, index, character)
  board[index] = character
  return board
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end


def valid_move?(board, index)
  if index > 8 || index < 0
    return false
  elsif !position_taken?(board, index)
    return true
  end
  return false
end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  character = current_player(board)
  if valid_move?(board, index)
		board = move(board, index, character)
	  puts display_board(board)
	else
    puts "invalid"
    user_input = gets.chomp
  end

end


def turn_count(board)
  occupied_count = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      occupied_count += 1
    end
  end
  return occupied_count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  if turn_count(board) % 2 != 0
    return "O"
  end
end


def won?(board)
	WIN_COMBINATIONS.each do |combinations|
   if board[combinations[0]] == "X" &&
      board[combinations[1]] == "X" &&
      board[combinations[2]] == "X"
      return combinations
   end
   if board[combinations[0]] == "O" &&
      board[combinations[1]] == "O" &&
      board[combinations[2]] == "O"
      return combinations
   end
  end
  return false
end


def full?(board)
  board.each do |position|
    if position == "" || position == " "
      return false
    end
  end
  return true
end


def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end


def over?(board)
 WIN_COMBINATIONS.each do |combination|
   if won?(board) == combination
     return true
   end
	 end
	 if draw?(board)
	   return true
	 elsif full?(board)
	   return true
	 end
	 return false
end


def winner(board)
  WIN_COMBINATIONS.each do |combination|
    if won?(board) == combination
      return board[combination[0]]
    end
  end
  return nil
end


def play(board)
		count = 0
    while count < 10 do
			if over?(board) == true
				break
			end
			turn(board)
			count += 1
		end

		if won?(board)
			puts "Congratulations #{winner(board)}!"
		end
		if draw?(board)
			puts "Cats Game!"
		end
end
