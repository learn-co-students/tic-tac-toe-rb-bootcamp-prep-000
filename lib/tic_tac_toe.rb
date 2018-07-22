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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end 

def input_to_index(x)
  index = x.to_i 
  index - 1 
end

def move(board, index, player)
  board[index] = player
end 

def position_taken?(board, index)
  !(board[index] == "" || board[index] == " " || board[index] == nil)
end

def valid_move?(board, index)
 index.between?(0,8) && !position_taken?(board, index)
end 

def turn(board)
  
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0 
  board.each do |player|
    if player == "X" || player == "O"
      count += 1 
    end
  end
    return count
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else
    return "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.detect do |combo|
       board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[0]) 
    end
  end
 
 
 
 def full?(board)
   board.none? do |value|
    value == " "
  end
end


def draw?(board)
  won?(board) == nil && full?(board) == true
end

def over?(board)
  draw?(board) == true || won?(board) != nil
end


def winner(board)
  if won?(board) == nil
    return nil
  elsif board[won?(board)[0]] == "O"
    return "O"
  elsif board[won?(board)[0]] == "X"
    return "X"
  end 
end

def play(board)
  until over?(board) ==  true
  turn(board)
end
 if draw?(board) == true 
   puts "Cat's Game!"
  elsif winner(board) == "X"
   puts "Congratulations X!"
  elsif winner(board) == "O"
   puts "Congratulations O!"
 end 
end
  