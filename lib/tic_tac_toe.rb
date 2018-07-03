
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
  rows=["","",""]
  line=["-----------"]
  rows.each_with_index do|pos,index|
    rows[index]=" #{board[rows.length*index]} | #{board[rows.length*index+1]} | #{board[rows.length*index+2]} "
  end
  puts [rows[0],line,rows[1],line,rows[2]]
end

def input_to_index(pos)
  pos.to_i-1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
  
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn=0  
  board.each do|spot|
    if (spot.strip=="X" || spot.strip=="O"||spot.strip=="x" || spot.strip=="o")
      turn+=1
    end
  end
return turn
end

def current_player(board)
  turn_count(board)%2==0 ? "X":"O"
end

def winning_player(board)
 board[won?(board)[0]]
end


def won?(board)
  players=["X","O"]
  WIN_COMBINATIONS.each do|combination|
    players.each do|player|
      if (board[combination[0]]===player && board[combination[1]]===player && board[combination[2]]===player )
       # puts "won!"
        return combination
      end
    end
  end
  return false
end

def full?(board)
  num_positions=board.select do|positions|
    positions=="X"||positions=="O"
  end
  num_positions.length==9 ? true :false
end

def draw?(board)
  full?(board)&&!won?(board) ? true : false
end
  
def over?(board)  
  draw?(board)||won?(board) ? true : false 
end

def winner(board)
  won?(board).kind_of?(Array) ? board[won?(board)[0]] : nil
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
 
#board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
#play(board)    
 