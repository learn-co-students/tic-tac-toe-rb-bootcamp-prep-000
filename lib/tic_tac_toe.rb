
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2],
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

def won?(board)
  WIN_COMBINATIONS.each do |x|
    p1 = board[x[0]]
    p2 = board[x[1]]
    p3 = board[x[2]]
    if p1 == "X" && p2 == "X" && p3 == "X"
      return [x[0], x[1], x[2]]
    elsif p1 == "O" && p2 == "O" && p3 == "O"
      return [x[0], x[1], x[2]]
    end
  end
  return false
end

def draw?(board)
  full?(board) && !won?(board)
end

def full?(board)
  board.each do |x|
    if x == " "
      return false
    end
  end
  true
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  count_x = 0
  count_o = 0
  board.each do |x|
    if x == "X"
      count_x +=1
    elsif x == "O"
      count_o +=1
    end
  end

  if won?(board) && count_x > count_o
    "X"
  elsif won?(board) && count_x < count_o
    "O"
  else
    nil
  end
end

def turn_count(board)
  count = 0
  board.each do |x|
    if x === "O" || x === "X"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 === 0
    "X"
  else
    "O"
  end
end

def turn(a)
  puts "Please enter 1-9:"
  input = gets.strip
  b = input_to_index(input)
  if valid_move?(a, b)
    move(a, b, current_player(a))
    display_board(a)
  else
    turn(a)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
