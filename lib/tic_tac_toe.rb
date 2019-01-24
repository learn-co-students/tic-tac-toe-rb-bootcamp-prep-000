require "pry"

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

def display_board (board)
  position = 0
  board.each_with_index do |value, index|
    if index == 2 || index == 5 || index == 8
      print " #{value} \n"
      puts "-----------"
    else
      print " #{value} |"
    end
  end
  puts "\n"
end

def input_to_index(user_input)
  output = nil
  user_input.split.each do |x|
    if x.is_a? Numeric
      output = -1
    else
      output = user_input.to_i - 1
    end
  end
  output
end

def valid_move?(board, index)
  valid_flag = false
  if (0..8).include?(index) && board[index] == " "
    valid_flag = true
  end
  valid_flag
end

def move (board, index, token)
  if token == "O"
  board[index] = token
  else
  board[index] = token
  end
end

def position_taken?(board, index)
  valid_flag = false
  if (0..8).include?(index) && board[index] == " " || board[index] == "X" || board[index] == "O"
    valid_flag = true
  end
  if board[index] == " " || board[index] == nil
    valid_flag = false
  end
  valid_flag
end

def turn(board)
  puts "Please enter 1-9:"
  token = current_player (board)
    input = input_to_index(gets.chomp)
    if valid_move?(board, input)
      move(board, input, token)
      display_board(board)
    else
      puts "Please enter 1-9:"
      input = input_to_index(gets.chomp)
    end
end

def turn_count (board)
  count = 0
  board.each do |x|
    if x != " "
      count += 1
    end
  end
  count
end

def current_player (board)
  current_player = ""
  if turn_count(board) == 0
    current_player = "X"
  end
  if turn_count(board)%2 == 0
    current_player = "X"
  else
    current_player = "O"
  end
end

def won?(board)
  winning_combo = nil
  WIN_COMBINATIONS.each do |combo|
    if combo.all? {|idx| board[idx] == "X"}
      winning_combo = combo
    elsif combo.all? {|idx| board[idx] == "O"}
      winning_combo = combo
    else
      false
    end
  end
  if winning_combo != nil
    winning_combo
  else
    false
  end
end

def full? (board)
  board.all? do |token|
    token == "X" || token == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  end
end

def winner(board)
  winner = nil
  WIN_COMBINATIONS.each do |combo|
    if combo.all? {|id| board[id] == "X"}
      winner = "X"
    elsif combo.all? {|id| board[id] == "O"}
      winner = "O"
    else
    end
  end
  winner
end

def play(board)
  turn(board) until over?(board)
    if winner(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
  end
end
