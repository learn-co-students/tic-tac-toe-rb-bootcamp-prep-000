WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8],[2,4,6]]

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
  board.reduce(0) {|count, place| count + (place == "X" || place == "O" ? 1 : 0)}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
WIN_COMBINATIONS.each do |comb|
  return comb if board[comb[0]] == board[comb[1]] && board[comb[0]] == board[comb[2]] && (board[comb[0]] == "X" || board[comb[0]] == "O")
  end
  return false
end

def full?(board)
  board.all? {|place| place == "X" || place == "O"}
end

def draw?(board)
  !won?(board) if full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  turn(board) until over?(board)
  puts "Congratulations #{winner(board)}!" if winner(board)
  puts "Cat's Game!" if draw?(board)
end