WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input="invalid")
  input.to_i - 1
end

def move(board, pos, token)
  board[pos] = token
end

def won?(board)
  WIN_COMBINATIONS.each do |arr|
    if board[arr[0]] != " " && board[arr[0]] == board[arr[1]]  && board[arr[0]] == board[arr[2]]
      return arr
    end
  end
  false
end

def full?(board)
  !board.any? {|e| e == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  return won?(board) ? board[won?(board)[0]] : nil
end

def turn_count(board)
  i = 0
  board.each {|e| i += 1 if e != " " }
  i
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
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
  if !valid_move?(board, index)
    turn(board)
  end
  move(board, index, current_player(board))
  display_board(board)
end

# Define your play method below
def play(board)
  while over?(board) == false  do
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  end
end
