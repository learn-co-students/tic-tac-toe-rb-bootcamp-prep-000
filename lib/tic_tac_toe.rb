
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
  ]
  
board = Array.new(9, " ")

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end 

def input_to_index(input)
  input.to_i-1
end 

def move(board, index, current_player)
  board[index] = current_player 
end 

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
  
def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end 

def turn_count(board)
  turn = 0 
  board.each do |index|
    if index != " "
    turn += 1   
  end 
  end 
  return turn  
end 

def current_player(board)
  if turn_count(board).even? 
    player = "X"
  else 
    player = "O"
  end
  return player 
end

def turn(board)
  puts "Choose 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) 
    move(board, index)
    return display_board(board)
  else 
    turn(board)
  end 
end 

def won?(board)
    WIN_COMBINATIONS.any? {|win_combo|
       index_0 = win_combo[0]
       index_1 = win_combo[1]
       index_2 = win_combo[2]
       
       position_1 = board[index_0]
       position_2 = board[index_1]
       position_3 = board[index_2]
    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      return win_combo
    end}
    return false 
end 

def full?(board)
  if board.include?(" ") || board.include?("")
  return false
    else
  return true 
end
end

def draw?(board)
  if full?(board) && !won?(board) 
  return true 
else 
 false 
end 
end

def over?(board)
  if won?(board) || draw?(board)
  return true 
else 
  return false 
end 
end 

 def winner(board)
  if (!won?(board))
    return nil 
  else 
    w_array = won?(board)
    position_1 = w_array[0]
  if (board[position_1] == "X")
  return "X"
  else 
  return "O"
end 
end 
end 

def play(board)
  until over?(board) || draw?(board)
   turn(board)
  end 
  if draw?(board)
    puts "Cat's Game!"
  else
    if won?(board)
    puts "Congratulations #{winner(board)}!"
  end 
end







