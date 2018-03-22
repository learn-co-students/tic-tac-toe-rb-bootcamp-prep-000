def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Helper Method

def position_taken?(board, index)
 (board[index] == "X" || board[index] == "O")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

def won?(board)
  marker = nil
  WIN_COMBINATIONS.select do|combo|
    if(position_taken?(board, combo[0]))
      marker = board[combo[0]]
      combo.all? {|i|board[i].include?(marker)}
    end
  end.pop
end

def full?(board)
  board.all? do|pos| 
    position_taken?(board, board.index(pos))
  end
end

def draw?(board)
  !won?(board)&&full?(board)
end

def over?(board)
  won?(board)||draw?(board)
end

def winner(board)
 won?(board) ?board[won?(board)[0]]:nil
end

def turn_count(board)
  count = 0 
  board.each do |turn|
    turn == "X" || turn == "O" ? count+= 1 : 0
  end
  return count
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end


def valid_move?(board, index)
  return index.between?(0,8) && !position_taken?(board, index)
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  return user_input.to_i - 1 
end

def move(board, index, player)
  board[index] = player
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)

  if(!valid_move?(board,index))
    turn(board)
  else
    player = current_player(board)
    move( board, index, player )
    display_board(board)
  end
end

def play(board)
 
  counter = 1 
  
  until over?(board) do
    turn(board)
    counter += 1 
  end
  if(winner(board)=="X")
    puts "Congratulations X!"
  elsif(winner(board)=="O")
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
  
  
end