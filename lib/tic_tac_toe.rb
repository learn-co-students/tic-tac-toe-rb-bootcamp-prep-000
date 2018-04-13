# Define your WIN_COMBINATIONS constant
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
  
# Display board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

#Input to index  
def input_to_index(input)
  index=input.to_i-1
end

#Move
def move(board,index,token="X")
  board[index]=token
end

#Position taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#Valid move
def valid_move?(board,index)
  if index.between?(0,8) == true && board[index] == " " || board[index] == ""
    return true
  else
    return false
  end
end

#Turn
def turn(board,marker)
  puts "Please enter 1-9:"
  
  input = gets.chomp
  
  index = input_to_index(input)
  if valid_move?(board,index) == false
    turn(board)
  end
  
  move(board,index,marker)
  
  display_board(board)
  
end

#Turn count
def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  return counter
end

#Current player
def current_player(board)
  whoturn = turn_count(board)
  
  if whoturn % 2 == 0
    return "X"
  else
    return "O"
  end
end

#Won
def won?(board)
    WIN_COMBINATIONS.each do |win_con|
      i=0
      markers=[" ", " ", " "]
      win_con.each do |index|
        markers[i] = board[index]
        i += 1
      end
      
      if markers == ["X", "X", "X"] || markers == ["O", "O", "O"]
        return win_con
      end
    end
    return false
  end
  
#Full  
  def full?(board)
    board.none?{|marker| marker == " "}
  end
  
#Draw  
  def draw?(board)
    if won?(board) == false && full?(board) == TRUE
      return TRUE
    else
      return false
    end
  end
  
#Over  
  def over?(board)
    if won?(board) or full?(board) or draw?(board)
      return true
    else
      return false
    end
  end
  
#Winner  
  def winner(board)
    if won?(board)
      index = won?(board)
      return board[index[0]]
    end
  end
  
#Play
def play(board)
  while !(over?(board))
    marker = current_player(board)
    puts marker
    turn(board,marker)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
    
