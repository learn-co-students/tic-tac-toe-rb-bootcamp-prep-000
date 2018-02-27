LINE = "-----------"

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts LINE
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts LINE
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, index, tic_or_tac)
  board[index] = tic_or_tac
end

def turn_count(board)
  board.select { |tic_or_tac| tic_or_tac == "X" || tic_or_tac == "O" }.length
end

def current_player(board)
	(turn_count(board).even?) ? "X" : "O"
end

def valid_move?(board, index)
  (!position_taken?(board, index) && index.between?(0, 8)) ? true : false
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

def input_to_index(input)
  input.to_i - 1
end

def won?(board)
	WIN_COMBINATIONS.each do |combination|
		combination_array = []
		combination.each do |position|
			combination_array << board[position]
		end
		if combination_array == ["X", "X", "X"] || combination_array == ["O", "O", "O"]
			return combination
		end
	end
	return false
end

def full?(board)
  board.all?{|position| position == "X" || position == "O"}
end

def draw?(board)
	!won?(board) && full?(board)
end

def over?(board)
	won?(board) || draw?(board)
end

def winner(board)
	won?(board) ? board[won?(board)[0]] : nil
end

def turn(board)
	puts "Which position do you want to go?"
	position = gets.strip
	index = input_to_index(position)
	if valid_move?(board, index) 
		tic_or_tac = current_player(board)
		move(board, index, tic_or_tac)
		display_board(board)
	else
		puts "Invalid position, please try again."
		turn(board)
	end
end

def play(board)
	while over?(board) == false
		turn(board)
	end
	
	if won?(board)
		puts "Congratulations #{winner(board)}!"
	elsif draw?(board)
		puts "Cat's Game!"
	end
end
