WIN_COMBINATIONS= [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
board = [" "," "," "," "," "," "," "," "," "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

display_board(board)

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, character)
  if character == "X" || character == "O"
   board[index]= character
  else
    raise ArgumentError
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board,index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each {|i| if i =="X" || i == "O"; count +=1  end}
  return count
end

def current_player(board)
  turn_count(board) % 2 == 0? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |i|
    if i.all? { |index| board[index] == "X"} || i.all? { |index| board[index] == "O"}
      return i
    end
  end
  return nil
end

def full?(board)
  board.none?{|spot| spot =="" || spot == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  while over?(board) == false
     turn(board) 
  end
  if won?(board) 
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) 
    puts "Cat's Game!"
  end
end