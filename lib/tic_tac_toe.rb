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
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end
def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
end
def valid_move?(board, index)
  (index.between?(0, 8) && !(position_taken?(board, index))) ? true:false
end
def turn_count(board)
  return board.count("X") + board.count("O")
end
def current_player(board)
  ((turn_count(board) % 2) == 1)? "O":"X"
end
def winning_player(board)
  (current_player(board) == "O")? "X":"O"
end
def won?(board)
  WIN_COMBINATIONS.each do |pos1, pos2, pos3|
    moves = [board[pos1],board[pos2],board[pos3]]
    ((moves == ["X","X","X"]) || (moves == ["O","O","O"])) ? (return [pos1, pos2, pos3]) : nil
  end
  return false
end
def full?(board)
  ((board.count("X") + board.count("O")) == 9) ? true:false
end
def draw?(board)
  (full?(board) && !(won?(board)))? true:false
end
def over?(board)
  (won?(board) || draw?(board) || full?(board))? true:false
end
def winner(board)
  (won?(board)) ? (return board[won?(board)[0]]) : nil
end
def turn(board)
  puts "Please enter a number: 1-9"
  answer = gets.chomp
  converted = input_to_index(answer)
  if valid_move?(board,converted)
    move(board, converted, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end
def play(board)
  while !(over?(board))
    turn(board)
  end
  won?(board) ? (puts "Congratulations #{winner(board)}!") : (puts "Cat's Game!")
end
