
WIN_COMBINATIONS=[
  [0,1,2],[3,4,5],[6,7,8],
  [0,3,6],[1,4,7],[2,5,8],
  [0,4,8],[2,4,6]
]
def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i-1
end

def move(board,position,token)
board[position]=token
end

def position_taken?(board,position)
  board[position]=="X" || board[position]=="O"
end

def valid_move?(board, position)
!position_taken?(board,position)&&board[position]==" "&&position<9 && position>=0
end

def turn(board)
puts "Please enter your move (1-9): "
user_input=gets.strip
position=input_to_index(user_input)
if (valid_move?(board,position))
  token=current_player(board)
  move(board,position,token)
  display_board(board)
else
  turn(board)
end
end

def turn_count(board)
count=0
board.each { |x|
  if x=="X" || x=="O"
    count +=1
  end
}
count
end

def current_player(board)
turn_count(board).even? ? "X": "O"
end

def won?(board)
WIN_COMBINATIONS.detect do |x|
 board[x[0]]==board[x[1]] && board[x[1]]==board[x[2]]&& (board[x[0]]=="X" || board[x[0]]== "O")
end
end

def full?(board)
!(board.include?("")||board.include?(" "))
end

def draw?(board)
  full?(board)&& !won?(board)
end


def over?(board)
won?(board) || draw?(board) || full?(board)
end

def winner(board)
if won?(board)
return board[won?(board)[0]]
end
end

def play(board)
until over?(board)
turn(board)
end
  if won?(board)
  puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
end
end
