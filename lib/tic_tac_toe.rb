WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end



def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board,index,current_player(board))
    display_board(board)
  else
   turn(board)
  end
end


def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end


def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.detect do |combination|
  
     if (board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X") ||
         (board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O")
        
        return combination
        
        else
          
        false 
    end
  end
end


def full?(board)
board.all? {|space| space == "X" || space == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
  end
  
def over?(board)
  won?(board) || draw?(board)
end
  
def winner(board)
  if won?(board).class == Array
    return board[won?(board)[0]]
  else
  return nil
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

