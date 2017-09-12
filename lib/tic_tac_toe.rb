# code your #valid_move? method here
def valid_move?(board,index)
  return ( index >= 0 && index < board.length ) && !position_taken?(board,index)
end
# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board,index)
  return !( board[index] == " " || board[index] == "" || board[index] == nil )
end
# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(n)
  n.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index, current_player(board))
    display_board(board)
  else
    puts "That is not a valid move."
    turn(board)
  end
end

def current_player(board)
  (turn_count(board) % 2 == 0) ? "X" : "O"
end

def turn_count(board)
  turns = 0
  board.each do |x|
    if x == "X" || x == "O"
      turns += 1
    end
  end
  return turns
end

def play(board)
  while !over?(board)
    turn(board)
  end

  puts "Cat's Game!" if draw?(board)
  puts "Congratulations #{winner(board)}!" if won?(board)
end
# Define your WIN_COMBINATIONS constant
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

def won?(board)
  arrays = WIN_COMBINATIONS.select { |c| ( board[c[0]] == board[c[1]] && board[c[0]] == board[c[2]] ) && ( board[c[0]] == "X" || board[c[0]] == "O" ) }
  if arrays == []
    return false
  else
    return arrays[0]
  end
end

def full?(board)
  arrays = board.select { |s| s == " " || s == "" }
  return arrays == []
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  winner = won?(board)
  if winner
    board[winner[0]]
  else
    nil
  end
end
