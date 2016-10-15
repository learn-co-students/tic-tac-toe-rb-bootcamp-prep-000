require 'pry'

WIN_COMBINATIONS = [
   # Row wins
   [0,1,2],
   [3,4,5],
   [6,7,8],
   # Column wins
   [0,3,6],
   [1,4,7],
   [2,5,8],
   # Diag wins
   [0,4,8],
   [6,4,2]
]


def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  seperator = "\n-----------\n"
  puts [row1,row2,row3].join(seperator)
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  0 <= index && index <= 9 && !(position_taken?(board, index))
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    puts "Invalid move!"
    turn(board)
  end

end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end


def current_player(board)
  x_count = board.count{|token| token == "X"}
  o_count = board.count{|token| token == "O"}
  if x_count > o_count then "O" else "X" end
end

def full?(board)
  board.all? {|space| space == "X" || space == "O"}
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
   won?(board) || draw?(board)
end

def winner(board)
  winning_combo = won?(board)
  if(winning_combo)
    return board[winning_combo.first]
  else
    return nil
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    x_wins = combo.all? {|i| board[i] == "X"}
    y_wins = combo.all? {|i| board[i] == "O"}
    if(x_wins || y_wins)
      return combo
    end
  end
  return nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    victor = winner(board)
    puts "Congratulations #{victor}!"
  else
    puts "Cats Game!"
  end
end
