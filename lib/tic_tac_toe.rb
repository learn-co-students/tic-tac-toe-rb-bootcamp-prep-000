WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts "-----------"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def move(board, index, player_token)
  board[index] = player_token
end

def position_taken?(board, index)
  board[index] != " "
end

=begin
ask for input
get input
convert input to index
if move is valid
  make the move for index and show board
else
  ask for input again until you get a valid move
end
=end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  input = input_to_index(input)
  player_token = current_player(board)
  if valid_move?(board, input)
    move(board, input, player_token)
else
   turn(board)#needs to be fixed
end
end

def current_player(board)
  count = turn_count(board)
  value = count % 2
  unless value == 1
    turn = "X"
  else
    turn = "O"
end
turn
end

def turn_count(board)
counter = 0
board.each do |spot|
  if spot == " "
    counter += 0
  else
    counter += 1
  end
end
counter
end

def won?(board)
  WIN_COMBINATIONS.find do |combination|  #using find, instead of iterating, we just locate the winning array, and return it

    board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X" ||
      board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
  end
end

def full?(board)
  !board.include?(" ") #if the board doesn't have any blank spaces, it is not full
end

def draw?(board)
  full?(board) && !won?(board)  #if full board, and no winner, game is a draw.
end

def over?(board)
  (full?(board) && draw?(board)) || won?(board)
  #if the board is full AND either there is a draw or someone wins, the game ends
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
end #if won?(board), return board[conbination[]] to identify winner
end

def play(board)
  until over?(board) || won?(board) || draw?(board)
    turn(board)
    display_board(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
end
end
