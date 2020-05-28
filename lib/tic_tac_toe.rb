require "pry"

WIN_COMBINATIONS = [
  [0,1,2],  #1st row
  [3,4,5],  #2nd row
  [6,7,8],  #3rd row
  [0,3,6],  #1st column
  [1,4,7],  #2nd column
  [2,5,8],  #3rd column
  [0,4,8],  #\ diagonal
  [2,4,6]   #/ diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1 
end

def move(board,index,char) 
  board[index] = char 
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end  

def position_taken?(board,index)
  board[index] == "X" || board[index] == "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
     if valid_move?(board,index) 
      move(board, index, current_player(board))
      display_board(board)
     else 
      turn(board)
  end
end

def turn_count(board)
  board.count do |board_element|
    board_element == "X" || board_element == "O"
  end
end 

def current_player(board)
      if turn_count(board) % 2 == 0 
        "X"  
      else 
        "O"
  end
end  

def won?(board)
  WIN_COMBINATIONS.detect do |winning_array|
    board[winning_array[0]] == board[winning_array[1]] && 
    board[winning_array[1]] == board[winning_array[2]] &&
    position_taken?(board, winning_array[0])
  end  
end

def full?(board)
  board.all? do |token|
    token == "X" || token == "O"
  end 
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board) 
  winning_array = won?(board)
    if winning_array
      board.at(winning_array[0])   
    end
end

def play(board)
  winning_array = won?(board)
  until over?(board)
      turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

