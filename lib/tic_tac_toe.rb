board = ["", "", "", "", "", "", "", "", ""]

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
  return -1 if user_input.scan(/\d/).empty?
  user_input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, idx)
  !(board[idx].nil? || board[idx] == " ")
end

def valid_move?(board, idx)
  return false if idx < 0 || idx > 8
  position_taken?(board, idx) ? false : true
end

def turn(board)
  puts "Enter a number 1-9:"
  user_input = gets.strip
  input = input_to_index(user_input)

  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)

  x_positions = []
  o_positions = []

  board.each_with_index do |x, i|
    x_positions << i if x == "X"
    o_positions << i if x == "O"
  end

  return nil if x_positions.empty? && o_positions.empty?

  WIN_COMBINATIONS.each do |combos|
    return combos if combos.all? {|x| o_positions.include?(x)}
    return combos if combos.all? {|x| x_positions.include?(x)}
  end

  false
end

def full?(board)
  positions = board.select {|x| x == "X" || x == "O"}
  positions.length == 9 ? true : false
end

def draw?(board)
  if won?(board) == false && full?(board)
    return true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    false
  end
end

def winner(board)
  if won?(board)
    first = won?(board)[0]
    return board[first]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  puts "Cats Game!" if draw?(board)
  puts "Congratulations #{winner(board)}!"
end
