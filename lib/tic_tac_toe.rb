# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # bottom row
  [0,3,6], # first column
  [1,4,7], # second column
  [2,5,8], # third column
  [0,4,8], # upper left to lower right
  [6,4,2]
]
# display the current board state -> io
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# transpose the user input to array_index -> int
def input_to_index(input)
		index = input.to_i - 1
		return index
end
# update the board with user's move -> io
def move(board, index, piece)
		board[index] = piece
end
# check to see if the position is taken -> bool
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
# check to see if the move is valid -> bool
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
# propt user for move -> io
def turn(board)
		piece = current_player(board)
		puts "Please enter 1-9:"
		input = gets.strip
		index = input_to_index(input)
		if valid_move?(board, index)
				move(board, index, piece)
				display_board(board)
		else
				turn(board)
		end
end
# get the turn count ->int
def turn_count(board)
  i = 0
  board.each do |piece|
    if piece == "X" || piece == "O"
      i += 1
    end
  end
  return i
end
# get the current player -> string
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
# check win status ->array?
def won?(board)
		WIN_COMBINATIONS.find { |combo|
				combo.all? {
						|comboIndex|
								board[comboIndex] == "X"
				} ||
						combo.all? {
						|comboIndex|
								board[comboIndex] == "O"
				}
		}
end
# check full board -> bool
def full?(board)
		board.all? {
				|position|
				position != " "
		}
end
# check draw status -> bool
def draw?(board)
		if !won?(board) && full?(board)
				return true
		else
				return false
		end
end
# check if game over -> bool
def over?(board)
		full?(board) || draw?(board) || won?(board)
end
# determine winner -> string
def winner(board)
		if won?(board)
				if (WIN_COMBINATIONS.find { |combo|
						combo.all? {
								|comboIndex|
										board[comboIndex] == "X"
						}})
						return "X"
				else
						return "O"
				end
		end
end
# engind for game
def play(board)
		until over?(board)
				turn(board)
		end
		if draw?(board)
				puts "Cat's Game!"
		elsif winner(board) != nil
				puts "Congratulations #{winner(board)}!"
		end

end



