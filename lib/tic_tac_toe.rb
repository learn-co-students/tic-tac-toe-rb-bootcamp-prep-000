def input_to_index(s)
  return (s.to_i)-1
end
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def valid_move?(board,n)
  return n>=0&&n<9&&board[n]!='X'&&board[n]!='O'
end
def move(board,n,char)
  board[n]=char
  return board
end

def turn(board)
  i=-1
  puts("Please enter 1-9:")
  loop do
    if valid_move?(board,i=input_to_index(gets))
      break
    end
    puts("Invalid move.")
  end
  move(board,i,current_player(board))
  display_board(board)
  return board
end
def turn_count(board)
  r=0
  board.each {|ch|(ch=='X'||ch=='O')?r+=1:0}
  return r
end
def current_player(board)
  return (turn_count(board)%2==0)?'X':'O'
end

def play(board)
  until(over?(board)) do
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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
def won?(board)
  return WIN_COMBINATIONS.find{|comb|
    ((comb.all?{|n| board[n]=='X'})||(comb.all?{|n| board[n]=='O'}))}
end
def full?(board)
  return board.all?{|a|a=='X'||a=='O'}
end
def draw?(board)
  return (!(won?(board)))&&full?(board)
end
def over?(board)
  return won?(board)||full?(board)
end
def winner(board)
  l=won?(board)
  if l==nil
    return nil
  else
    return board[l[0]]
  end
end
