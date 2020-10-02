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

def input_to_index(input)
  input.to_i - 1
end

def move(board,index,token)
  board[index]=token
end

def position_taken?(board,index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    return true
  end
end

def valid_move?(board,input)
  !position_taken?(board,input) && input.between?(0,8)
end

def turn(board)
  puts "What is your move?"
  input = input_to_index(gets.strip)
  if valid_move?(board,input)
    move(board,input,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter +=1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") ||
      (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O")
      return combo
    end
  end
  false
end

def full?(board)
  board.all?{|i| i=="X"||i=="O"}
end

def draw?(board)
  if( full?(board) == true && won?(board) == false )
    return true
  else
    false
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
    nil
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
