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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board,index,player)
  board[index] = player
end

def position_taken?(board,index)
  board[index]== "X" || board[index] == "O"
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
#  puts "Please input the number[1-9]:"
  user_input = gets.strip
  index = input_to_index(user_input)
  player = current_player(board)
  if valid_move?(board,index)
    move(board,index,player)
#    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  a = board.select{|i| i!=" "}
  a.length
end

def current_player(board)
  (turn_count(board).even?)? "X": "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |com|
    board[com[0]] == board[com[1]] &&
    board[com[1]] == board[com[2]] &&
    position_taken?(board,com[0])
  end
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if !draw?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
