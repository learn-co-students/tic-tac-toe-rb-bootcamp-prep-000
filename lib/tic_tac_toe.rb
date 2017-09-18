
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

def input_to_index(index)

  index = index.to_i
  index - 1

end

def move(array, index, value)

  array[index] = value

end

def position_taken?(board, index)

  if board[index] == " " || board[index] == ""
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end

end

def valid_move?(board, index)

  index.between?(0,8) && !position_taken?(board, index)

end

def turn(board)

  puts "Please enter 1-9:"

  input = gets.chomp

  input = input_to_index(input)

  until valid_move?(board, input) == true
    puts "invalid move try again"
    input = gets.chomp
    input = input_to_index(input)
  end

  value = current_player(board)

  move(board,input,value)

  display_board(board)

end

def turn_count(board)
  count = 0
  board.each do |x|
    if x == "X" || x == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)

  if turn_count(board).even? == true
    return "X"
  else
    return "O"
  end
end


def won?(board)

	count = 0

	WIN_COMBINATIONS.each do |awin|

		if board[awin[0]] == "X" && board[awin[1]] == "X" && board[awin[2]] == "X"
			return awin
     	break
		elsif board[awin[0]] == "O" && board[awin[1]] == "O" && board[awin[2]] == "O"
			return awin
     	break
		end
    count += 1
  end

	if count == 8
		return false
	end
end

def full?(board)

  count = 0

  board.each do |x|
    if x == "X" || x == "O"
      count += 1
    end
  end

  if count == 9
    return true
  else
    return false
  end
end

def draw?(board)

  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

def over?(board)

  if draw?(board) == true || full?(board) == true || won?(board) != false
    return true
  else
    return false
  end
end

def winner(board)

  if won?(board) != false

    if board[won?(board)[0]] == "X"
      return "X"
    elsif board[won?(board)[0]] == "O"
      return "O"
    end

  else
    return nil
  end
end

def play(board)

  until over?(board) == true
	   turn(board)
  end

  if draw?(board) == false
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    end
  else
    puts "Cat's Game!"
  end

end
