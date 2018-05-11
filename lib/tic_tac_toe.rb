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
  board[location].strip != ""
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
  turns = 0
  board.each do |spot|
    if spot == "X" || spot == "O" then turns += 1 end
  end
  turns
end

def current_player(board)
  turn_count(board).even? ? player = "X" : player = "O" 
end

def won?(board)
  result = false
  WIN_COMBINATIONS.each do |set|
    if board[set[0]] == "X" && board[set[1]] == "X" && board[set[2]] == "X"
      result = set
      break
    elsif board[set[0]] == "O" && board[set[1]] == "O" && board[set[2]] == "O"
      result = set
      break
    end
  end
  result
end

def full?(board)
  filled = board.all? do |spot|
    spot != " " && spot != ""
  end
end

def draw?(board)
  won?(board) == false && full?(board)
end

def over?(board)
  won?(board) != false || draw?(board)
end

def winner(board)
  outcome = won?(board)
  if outcome != false
    board[outcome[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  letter = winner(board)
  if letter != nil
    puts "Congratulations #{letter}!"
  else
    puts "Cat's Game!"
  end
end

