WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],# bottom row
  [0,3,6],#left column
  [1,4,7],#middle column
  [2,5,8],#right column
  [0,4,8], #cross
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
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
  played = 0
  board.each do |el|
    if el == "X" || el == "O"
      played += 1
    end
  end
  return played
end

def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"

end

def won?(board)
   WIN_COMBINATIONS.each do |win_index|
   	 x_match = 0
	   o_match = 0
  	for pos in win_index
  		if board[pos] == "X"
  			x_match += 1
  			if x_match == 3
  				return win_index
  			end
		elsif board[pos] == "O"
  			o_match += 1
  			if o_match == 3
  				return win_index
			end
		else
			break;
		end
  	end
  end
	return false
end

def full?(board)
  board.none? do |el|
    el == " " || el == "   "
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
      return true
  elsif full?(board) == false 
  	return false
	else false
end
end

def over?(board)
  if won?(board) != false || draw?(board) == true
    return true
  else false
  end
end

def winner(board)
ind = won?(board)
if ind == false
  return nil
 end
pos = ind[0]
if board[pos] == "X"
  return "X"
else return "O"
end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
