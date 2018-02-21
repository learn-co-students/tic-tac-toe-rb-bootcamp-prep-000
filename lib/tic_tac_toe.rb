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
puts" #{board[0]} | #{board[1]} | #{board[2]} "   
puts"-----------"
puts" #{board[3]} | #{board[4]} | #{board[5]} "
puts"-----------"
puts" #{board[6]} | #{board[7]} | #{board[8]} " 
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, player)
  board[index]=player
end

def position_taken?(board,index)
  if board[index] == ""|| board[index] == " " || board[index] == nil
   false
  else
   true
  end
end

  def valid_move?(board, index)
  if !position_taken?(board, index)  && index.between?(0,board.length-1) 
    true
  else
    false
  end
end


def turn(board)
  puts "Please enter 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, current_player(board))
    puts display_board(board)
  else
  turn(board)
  end
 end
 
 def turn_count(board)
  counter = 0
  board.each do |turn|
      if turn == "X" || turn == "O"
      counter += 1
    else
      counter += 0
    end
  end
  counter
end
  def current_player(board)
    if turn_count(board) % 2 == 0 
      "X"
    else
      "O"
  end
end

def won?(board)
  winner = []
  empty_board = board.all? {|x| x == " "}
  WIN_COMBINATIONS.each do |win_combination|
    if win_combination.all? { |win_index| board[win_index] =="X" } || win_combination.all? { |win_index| board[win_index] =="O" }
     winner = win_combination
     
   else
     false
    end
  end
  if winner == []
    false
  else
    winner
  end
end

def full?(board)
  !board.any? { |x| x == " " }
end

def draw?(board)
  if  full?(board)  && !won?(board)
    true
  else
     false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end
  
def winner(board)
  if !won?(board)
    nil
  elsif won?(board).all? {|value| board[value] == "X"}
    "X"
  elsif won?(board).all? {|value| board[value] == "O"}
    "O"
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


