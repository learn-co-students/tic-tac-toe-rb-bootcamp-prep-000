WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8],
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

def move(board, index, player_token)
  board[index] = player_token
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  counter  = 0
  board.each do |turn|
  if turn == "X" || turn == "O"
       counter += 1
  end
end
return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.each do |combination|
     if (board[combination[0]]==board[combination[1]] && board[combination[1]]==board[combination[2]])&& position_taken?(board, combination[0])
      return combination
end
  end
  return false
end 
 
 def full?(board)
   board.all? do |position|
     position == "X" || position == "O"
   end
 end
  
 
 def draw?(board)
   !won?(board) && full?(board)
   end
 
  def over?(board)   
    won?(board) || draw?(board) 
  end
  
  
  def winner(board)
    combination = won?(board)
     if combination
      return board[combination[0]]
  else
    return nil
  end
end


def play(board)
  
  turn(board) until over?(board)
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cat\'s Game!"
  end
end
 

