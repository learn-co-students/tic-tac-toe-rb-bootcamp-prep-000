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

def input_to_index(integer)
 integer.to_i - 1
end
def move(board, index, token)
 board[index] = token
end
def position_taken?(board, index)
 board[index] == " " ? false : true
end
def valid_move?(board, index)
 position_taken?(board, index) == false && index.to_i.between?(0, 8) == true ? true : false
end
def turn(board)
  display_board(board)
  puts "Please Enter 1-9"
  index = input_to_index(gets)
  turn_count(board).odd? ? token = "O" : token = "X"
  valid_move?(board, index) == true ? move(board, index, token) : turn(board)
end
def turn_count(board)
 board.count {|el| el != " "}
end
def current_player (board)
 turn_count(board).odd? == true ? "O" : "X"
end
def won?(board)
  WIN_COMBINATIONS.any? do |ar|
    board[ar[0]] == board[ar[1]] &&
    board[ar[1]] == board[ar[2]] &&
    position_taken?(board, ar[0])
 end
end
def full?(board)
 board.all? {|el| el != " "}
end
def draw?(board)
 !won?(board) && full?(board) == true ? true : false
end
def over?(board)
 won?(board) || draw?(board)
end
def winner(board)
  ar = (WIN_COMBINATIONS.select do |ar|
      board[ar[0]] == board[ar[1]] &&
      board[ar[1]] == board[ar[2]] &&
      position_taken?(board, ar[0])
    end)

  won?(board) == true ? board[ar[0][0]] : nil
end

def play(board)
 while !over?(board)
   turn(board)
end
if won?(board)
  display_board(board)
   puts "Congratulations #{winner(board)}!"
elsif draw?(board)
   puts "Cats Game!"
end
end
