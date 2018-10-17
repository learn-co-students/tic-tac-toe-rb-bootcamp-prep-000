# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[
  [0,1,2],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [3,4,5],
  [2,4,6],
  [2,5,8],
  [6,7,8]
  ]
  
def play(board)
  until over?(board)
    turn(board)
  end
  #winner(board)=="X" ? puts "Congratulations X!" 
  #  : winner(board)=="O" ? puts "Congratulations O!"
  #  : puts "Cat's Game!"
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else puts "Cat's Game!"
  end#if
end
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input=input.to_i
  index=input-1
  return index
end

def move(board, index, player)
  if(valid_move?(board,index))
    board[index]=player
    return board
  end
  turn(board)
  #display_board(board)
end

def position_taken?(board, index)
  !((board[index]==" ") || (board[index].to_s.empty?) || (board[index].nil?))
end

def valid_move?(board,index)
  if(index.between?(0,8))
    if( (board[index]==" ") || (board[index].to_s.empty?) || (board[index].nil?))
      return TRUE
    end
  end
  return false
end

def turn(board) 
  puts "Please enter 1-9:"
  input = gets.strip
  index=input_to_index(input)
  move(board, index, current_player(board)) 
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each{|place| blank?(place) ? nil : turn+=1}
  turn
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  #board.find{|combo| combo.all?{|position| (position=="X")||(position=="O")} ? combo : nil}
  WIN_COMBINATIONS.find{|combo| 
    combo.all?{|position| board[position] == "X"} ||
    combo.all?{|position| board[position] == "O"}
  } 
end #won

def full?(board)
  board.all?{|position| (position=="X")||(position=="O")}
end #full

def draw?(board)
  full?(board) ? 
                won?(board) ? nil : TRUE
                : nil 
end #draw

def over?(board)
  won?(board)||full?(board)||draw?(board) 
end #over

def winner(board)
  #won?(board).all?{|position| position=="X" ? "X" : position=="O" ? "O" : nil }
  if !won?(board).nil?
  won?(board).all?{|position| board[position] == "X"} ? "X" 
    : won?(board).all?{|position| board[position] == "O"} ? "O" 
    : nil
  end#if
end #winner

def blank?(place)
  (place == " ") || (place.to_s.empty?) || (place.nil?)
end