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

def input_to_index(input)
  return -1 if input.to_i.to_s != input
  input = input.to_i - 1
end

def move(board, index, sign)
  board[index] = sign
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  return false if index < 0 || index > 8
  !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9"
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each {|ch| count += 1 if ch != " "}
  count
end

def current_player(board)
  turn_count(board) % 2 == 0? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    return combo if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
    return combo if board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
  end
  false
end

def full?(board)
  board.each{|ch| return false if ch == " "}
  true
end

def draw?(board)
  return false if won?(board)
  full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  return nil if !won?(board)
  board[won?(board)[0]]
end

def play(board)
  while !over?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cats Game!" if draw?(board)
end
