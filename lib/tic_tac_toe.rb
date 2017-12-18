WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
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
  i = 0
  board.each do |element|
    if element != " "
      i+=1
    end
  end
  return i
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |cond|
    term1 = cond[0]
    term2 = cond[1]
    term3 = cond[2]

    p1 = board[term1]
    p2 = board[term2]
    p3 = board[term3]

    if p1 != " " && p1 == p2 && p2 == p3
      return cond
    end
  end
  return false
end

def full?(board)
  return !board.include?(" ")
end

def draw?(board)
  if full?(board)
    return !won?(board)
  else false
  end
end

def over?(board)
  if full?(board) || won?(board)
    return true
  else false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until(over?(board) || draw?(board))
    turn(board)
  end
  if won?(board)
    symbol = winner(board)
    puts "Congratulations #{symbol}!"
  else
    puts "Cat's Game!"
  end
end
