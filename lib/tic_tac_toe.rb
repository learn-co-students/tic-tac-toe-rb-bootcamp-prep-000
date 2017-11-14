WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index] == " " || board[index] == "")? true : false
end

def valid_move?(board, position)
  if !position_taken?(board, position) && position.between?(0,8)
   true
 else
   false
 end
end

def turn(board)
  puts "aksing input 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) && index.between?(0,8)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|el| el=="X" || el=="O"}
end

def current_player(board)
  num = turn_count(board)
  num.even?? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_comb|
    board[win_comb[0]] == board[win_comb[1]] &&
    board[win_comb[1]] == board[win_comb[2]] &&
    position_taken?(board, win_comb[0])
  end
end

def full?(board)
  board.all?{|el| el=="X" || el=="O"}
end

def draw?(board)
  !won?(board) && full?(board)? true : false
end

def over?(board)
  (won?(board) || draw?(board)|| full?(board))? true : false
end

def winner(board)
  if win_comb = won?(board)
    board[win_comb.first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts  "Cat's Game!"
  end

end
