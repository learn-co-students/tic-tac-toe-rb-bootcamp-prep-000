WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  [0, 4, 8], [2, 4, 6]
  ]

  def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

def input_to_index(input)
  index = input.to_i
  output = index - 1
  return output
end

def move(board, index, chrct)
return board[index] = chrct
end

def position_taken?(board, index)
if board[index] == "X" || board[index] == "O"
  return true
else
  return false
end
end

def valid_move?(board, index)
	 position = index + 1
  if !position_taken?(board, index) && position.between?(1, 9)
    return true
  else
    return false
  end
  end

  def turn(board)
puts "Please enter 1-9:"
numb = gets.strip
numb2 = input_to_index(numb)

if valid_move?(board, numb2) == false
  puts "invalid move"
  turn(board)
end
  move(board, numb2, chrt="X")

   display_board(board)
end

def turn_count(board)
 count = 0
 board.each { |chrt|
 if chrt == "X" || chrt == "O"
  count += 1
  end
}
 return count
 end


def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"

  end

  def won?(board)
    WIN_COMBINATIONS.detect {|combination|

	if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
	return combination
	elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
	return combination
	else
	false
	end
		}
end

def full?(board)

  if board.detect {|index|
    index == nil || index == " "}
    return false
  else
    return true
  end
end


def draw?(board)
if !won?(board) && full?(board)
  return true
else
  return false
end
end

def over?(board)
if won?(board) || full?(board) || draw?(board)
  return true
end
end

def winner(board)

 WIN_COMBINATIONS.detect {|combination|

	if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
	return "X"
	elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
	return "O"
	else
	nil
	end
		}
end

def play(board)
until over?(board)
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
else
  puts "Cat's Game!"
end
end
