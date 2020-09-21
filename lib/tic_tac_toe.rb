def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end





WIN_COMBINATIONS = [
  [0,1,2],
  [0,3,6],
  [0,4,8],
  [1,4,7],
  [3,4,5],
  [2,4,6],
  [6,7,8],
  [2,5,8]
]
def won?(board)
  WIN_COMBINATIONS.each do |winner|
    index_0 = winner[0]
    index_1 = winner[1]
    index_2 = winner[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]
    if position_1 == "X" && position_2 == "X" && position_3 == "X" ||
       position_1 == "O" && position_2 == "O" && position_3 == "O"
      return winner
    end
  end
    false
end

def full?(board)
  board.all?{|player| player == "X" || player == "O"}
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end

def current_player(board)
  if turn_count(board).even?
  "X"
else
  "O"
end
end

def turn_count(board)
  turns = 0
  board.each do |player|
    if player == "X" || player == "O"
      turns += 1
    end
  end
  turns
end

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

def move(board, index, player)
board[index] = player
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    true
  else
    false
  end
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
