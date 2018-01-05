
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

#ttt-4: Display what the current board looks like with all pieces placed
def display_board(board)
  bar = "|"
  line = "-----------"

  puts " #{board[0]} #{bar} #{board[1]} #{bar} #{board[2]} "
  puts line
  puts " #{board[3]} #{bar} #{board[4]} #{bar} #{board[5]} "
  puts line
  puts " #{board[6]} #{bar} #{board[7]} #{bar} #{board[8]} "

end

#ttt-5: takes in the value of user and converts it to the correct # for the board position
def input_to_index(move)
  move.to_i - 1
end


def move(board, index, player)
  board[index] = player
end

#ttt-6
def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

#ttt-7
def valid_move?(board, index)
  index >= 0 && index <= 8 && !position_taken?(board, index)
end

#ttt-8
def turn(board)
   puts "Please enter 1-9:"
   input = gets.strip
   num = input_to_index(input)
   if valid_move?(board, num) == false
     turn(board)
   else
     move(board, num, current_player(board))
   end
   display_board(board)
end

#ttt-10
def turn_count(board)
  counter = 0
  board.each do |move|
    move == "X" || move == "O" ? counter += 1 : counter += 0
  end
  return counter
end


def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

#ttt-11
def won?(board)
  WIN_COMBINATIONS.detect do |i|
    board[i[0]] == board[i[1]] &&
    board[i[0]] == board[i[2]] &&
    position_taken?(board, i[0])
  end
end


def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end


def draw?(board)
  !won?(board) && full?(board)
end


def over?(board)
  won?(board) || draw?(board)
end


def winner(board)
  i = won?(board)
  if won?(board)
    board[i[0]]
  end
end


def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
