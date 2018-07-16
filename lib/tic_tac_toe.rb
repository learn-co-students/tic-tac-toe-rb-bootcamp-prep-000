WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

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

def move(board, index, player_token)
  board[index] = player_token
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
    move(board, index, player_token = current_player(board))
  else
    puts "Invalid"
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |box|
    if box == "X" || box == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2 == 0? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    return combo if (board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" ||
    board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O" )
  end
  false if board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
end

def full?(board)
  true if board.none?{|i| i == " "}
end

def draw?(board)
  true if full?(board) && !(won?(board))
end

def over?(board)
  true if won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    win_array = won?(board)
    return board[win_array[0]]
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  if draw?(board)
    puts "Cat\'s Game!"
  end
end
