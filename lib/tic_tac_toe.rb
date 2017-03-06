
WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(pos)
pos = pos.to_i - 1
end

def move(board, position, value)


  board[position] = value
end

def position_taken?(board, position)
  board[position]== "X" || board[position] == "O"
end


def valid_move?(board,position)
position.between?(0,8) && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter 1-9:"
  pos = gets.strip
  position = input_to_index(pos)
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
    counter = 0
  board.each do |element|
    if element == "X" || element == "O"
      counter+=1
    end
    end
   counter
end

def current_player(board)
  turn_count = turn_count(board)
  if turn_count % 2 == 0
    "X"
  else "O"
  end
end

def won?(board)
WIN_COMBINATIONS.detect do |combo|
board[combo[0]] == board[combo[1]] &&
board[combo[1]] == board[combo[2]] &&
position_taken?(board, combo[0])
end
end

def full?(board)
board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
!won?(board) && full?(board)
end

def over?(board)
won?(board) || draw?(board)
end

def winner(board)

if winning_combo = won?(board)
board[winning_combo.first]
end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
