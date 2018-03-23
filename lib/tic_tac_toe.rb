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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  if (board[index] == " " || board[index] == "" || board[index] == nil)
    false
  else
    true
  end
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |move|
    if (move == "X" || move == "O")
      counter += 1
    end
  end
  return counter
end

def turn(board)
  player = turn_count(board) % 2 == 0 ? "X" : "O"
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if ( win.all?{|i| board[i] == "O"} || win.all?{|i| board[i] == "X"} )
      return win
    end
  end
   false
end

def full?(board)
  board.all?{|i| i != " "}
end

def draw?(board)
  won?(board) == false && full?(board)
end

def over?(board)
  won?(board) != false || draw?(board)
end

def winner(board)
  if win = won?(board)
    board[win[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  puts winner(board) ? "Congratulations #{winner(board)}!" : "Cat's Game!"
end
