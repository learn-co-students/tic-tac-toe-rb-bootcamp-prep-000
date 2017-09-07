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


def input_to_index(number)
  number.to_i-1
end

def valid_move?(board,index)
    index.between?(0,8) && !position_taken?(board,index)
end

def position_taken?(board,index)
  if board[index] ==" " || board[index]==nil || board[index]==""
    false
  else
    true
  end
end

def move(board,position,character)
  board[position]=character
end

def turn(board)
  puts "Please enter 1-9:"
  index=input_to_index(gets.strip)

  if valid_move?(board,index)
      move(board,index,current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def current_player(board)
  #count=turn_count(board)
  turn_count(board).even? ? "X" : "O"
end


def turn_count(board)
  count=0;
  board.each do |turn|
    if turn=="O" || turn=="X"
      count+=1
    end
  end
  count
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1=win_combination[0]
    win_index_2=win_combination[1]
    win_index_3=win_combination[2]

    position_1=board[win_index_1]
    position_2=board[win_index_2]
    position_3=board[win_index_3]

    if position_1=="X" && position_2=="X" && position_3=="X"
      return win_combination
    elsif position_1=="O" && position_2=="O" && position_3=="O"
      return win_combination
    end
  end
  false
end

def full?(board)
  board.none?{|chara| chara==" "||chara==""}
end

def draw?(board)
  won?(board) ? false : full?(board)
end

def over?(board)
  won?(board)|| full?(board) || draw?(board)
end

def winner(board)
  if combination=won?(board)
    #combination=won?(board)
    return board[combination[0]]
  end
end

#board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end
