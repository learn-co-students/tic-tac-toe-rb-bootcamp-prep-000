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

def input_to_index(input)
  input.to_i - 1
end

def move(board,index,token)
  board[index]=token
end

def position_taken?(board,index)
  !(board[index]==" " || board[index].nil? ||board[index]=="")
  #board[index] != " " && board[index] != "" && board[index].nil?
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  puts "move 1-9 please"
  input = gets.chomp.to_i
  index = input - 1
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|x|x=="X"||x=="O"}
end

def current_player(board)
  turn_count(board)%2==0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect { |combo| board[combo[0]]==board[combo[1]] && board[combo[1]]==board[combo[2]] && position_taken?(board,combo[0]) }
end

def full?(board)
  board.all?{|x|x=="X"||x=="O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board) || full?(board)
end

def winner(board)
  #if won?(board)!=false && !won?(board).nil?
  #  board[won?(board).first]
  #end
  if won?(board).kind_of?(Array)
    board[won?(board).first]
  end
  #won?(board)
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
