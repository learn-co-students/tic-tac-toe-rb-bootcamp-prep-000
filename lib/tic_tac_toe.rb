
WIN_COMBINATIONS=[
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
  input.to_i-1
end

def move(board, index, player)
  board[index]=player
end

def position_taken?(board, index)
  if board[index]==" " || board[index]==nil || board[index]==""
    false
  elsif board[index]=="X" ||  board[index]=="O"
    true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index)
    false
  elsif index>=0 && index <=8
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  index=input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end


def turn_count(board)
  counter=0
  board.each do |b|
    if b=="X" || b=="O"
      counter+=1
    end
  end
  counter
end

def current_player(board)
  turn_count(board)
  if turn_count(board)%2==0
    "X"
  else
    "O"
  end
end


def won?(board)
  combo=WIN_COMBINATIONS.detect do |win_combination|
    win_index_1=win_combination[0]
    win_index_2=win_combination[1]
    win_index_3=win_combination[2]

    position_1=board[win_index_1]
    position_2=board[win_index_2]
    position_3=board[win_index_3]

     position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
  end
  combo.nil? ? false: combo
end

def full?(board)
  board.all? {|i| i=="X" || i=="O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    true
end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
end
end


def winner(board)
  a=won?(board)
  if !a
    nil
  elsif board[a[0]]=="X"
    "X"
  elsif board[a[0]]=="O"
    "O"
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
