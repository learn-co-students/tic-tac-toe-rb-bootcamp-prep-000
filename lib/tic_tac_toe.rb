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
 
def input_to_index(user_input)
    user_input.to_i - 1
end
 
def move(board, index, player)
    board[index] = player
end
 
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
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

def turn_count (board)
  counter = 0
board.each do |token|
  if token == 'O' || token == 'X'
    counter += 1
    end
  end
  return counter
end

def current_player(board)
    if turn_count(board) % 2 == 0
      return 'X'
    else
      return 'O'
  end
  return current_player
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      if (board[win_combination[0]]) == "X" && (board[win_combination[1]]) == "X" && (board[win_combination[2]]) == "X" ||(board[win_combination[0]]) == "O" && (board[win_combination[1]]) == "O" && (board[win_combination[2]]) == "O"
      return win_combination
      
      end
    end
  false
  end 
  
  def full?(board)
    board.none?{|i| i == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
  if (board[win_combination[0]]) == "X" && (board[win_combination[1]]) == "X" && (board[win_combination[2]]) == "X" 
  return 'X'
    
  elsif (board[win_combination[0]]) == "O" && (board[win_combination[1]]) == "O" && (board[win_combination[2]]) == "O"
  return 'O'
 
    end
  end
  nil
end

def play(board)
  until over?(board) 
    turn(board)
  end
end

if won?(board)
  puts "Congratulations #{winner(board)}!"
else
  puts "Cat's Game"
  end 
end
