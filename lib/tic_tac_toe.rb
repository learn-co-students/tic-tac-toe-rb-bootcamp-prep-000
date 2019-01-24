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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, position)
  if board[position] != " "
    return true
  else
    return false
  end
end

def valid_move?(board, position)
  if (position_taken?(board, position)) == false && position.between?(0,9)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please select position 1-9:"
  user_input = gets.strip
  input_to_index(user_input)
  position = input_to_index(user_input)
  if valid_move?(board, position) == true
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |x|
    if x == "X" || x == "O"
      counter += 1
    else
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|

    i1 = win_combination[0]
    i2 = win_combination[1]
    i3 = win_combination[2]

    p1 = board[i1]
    p2 = board[i2]
    p3 = board[i3]

    if p1 == "X" && p2 == "X" && p3 =="X" || p1 == "O" && p2 == "O" && p3 == "O"
      return win_combination
    else
    end
  end
  return false
end

def full?(board)
  turn_count(board) == 9
end

def draw?(board)
  won?(board) == false && full?(board) == true
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  x = won?(board)
  if won?(board)
    return board[x[0]]
  else
     nil
  end
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
