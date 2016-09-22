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

$char == "O"

def char_changer
  if $char == "O"
    $char = "X"
  else
    $char = "O"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
  index = num.to_i
  index -= 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
  $char = "X"
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, $char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |variable|
    if variable == "X"
      counter += 1
    elsif variable == "O"
      counter += 1
    else
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) == 0
    return "X"
  elsif turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  oo = []
  WIN_COMBINATIONS.each do |e1|
    e1.each {|e2| oo << board[e2]}
    if oo.all? {|e3| e3 == "X"} || oo.all? {|e3| e3 == "O"}
      return e1
    else
      oo = []
    end
  end
  return false
end

def full?(board)
  board.all? {|e| position_taken?(board, board.index(e))}
end

def draw?(board)
  if won?(board) || full?(board) == false
    return false
  else
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if draw?(board) || over?(board) == false
    return nil
  else
    return board[won?(board)[0]]
  end
end

def play(board)
  $char = "O"
  until over?(board) do
    char_changer
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, $char)
      display_board(board)
    else
      turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
