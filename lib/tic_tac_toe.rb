def display_board(board)
  print_spaces(board[0],board[1],board[2])
  print_dash
  print_spaces(board[3],board[4],board[5])
  print_dash
  print_spaces(board[6],board[7],board[8])
end

def print_dash
  puts "-----------"
end

def print_spaces (val1, val2, val3)
  puts " #{val1} | #{val2} | #{val3} "
end

def move(board,index,token)
  if valid_move?(board,index)
    board[index]=token
    return true
  else
    return false
  end
end

def input_to_index(input)
  return input.to_i - 1
end

def valid_move?(board,index)
  if !position_taken?(board,index) && index>=0 && index <=8
    return true
  else
    return false
  end
end
  
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if move(board,index,token)
    display_board(board)
  else
    puts "This is not a valid move."
    turn(board)
  end
end

def turn_count(board)
  turn = 0
  board.each do |space|
    if space != "" && space != " "
      turn +=1
    end
  end
  return turn
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def won? (board)
  WIN_COMBINATIONS.each do |combo|
    if equality?(board,combo)
      return combo
    end
  end
  return nil
end

def equality?(board,combination)
  board_vals = []
  combination.each do |val|
    board_vals << board[val]
  end
  if board_vals.all?{|space| space == "X"} || board_vals.all?{|space| space == "O"}
    return true
  else
    return false
  end
end

def full?(board)
  if board.none?{|val| val==""} && board.none?{|val| val==" "}
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
