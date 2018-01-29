WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #left diagonal
  [2, 4, 6]  #right diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  if board[position] == " "
    return false
  elsif (board[position] == "X" || board[position] == "O")
    return true
  end
end

def valid_move?(board, position)
  if (!position_taken?(board, position) && position.between?(0, 8))
    return true
  else
    return false
  end
end
=begin
def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if(valid_move?(board, index))
    move(board, index)
    display(board)
  else
    puts "That is not a valid selection."
    turn(board)
  end
end
=end
def turn_count(board)
  counter = 0
  board.each do |location|
    if (location === "X" || location === "O")
      counter += 1
  end
  counter
end

def current_player

end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    firstSpot = combo[0]
    secondSpot = combo[1]
    thirdSpot = combo[2]
    if (board[firstSpot]===board[secondSpot] && board[secondSpot]===board[thirdSpot])
      return true
    else
      return false
    end
  combo
  end
end

def full?(board)
  if (board.include?(" "))
    return false
  else
    return true
  end
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if (won?(board) || full?(board))
    return true
  else
    return false
  end
end

def winner(board)

end
