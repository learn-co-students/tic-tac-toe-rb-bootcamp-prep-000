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
  if index.between?(0,8) && !position_taken?(board,index)
    return true
  else
    return false
  end
end  

def position_taken?(board,index)
  if board[index] == " " || board[index] == ""
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  else  board[index] == nil
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
    
    if valid_move?(board,index) == true
      move(board, index, "X")
      display_board(board)
      puts "Please enter 1-9:"
    else 
      turn(board)
  end
end

def play(board)
  count=0
  while count < 9
    turn(board)
    count += 1
  end
end  

def turn_count(board)
  count = 0
  board.each do |board_element|
    if board_element == "X" || board_element == "O"
      count += 1
    end
  end
  return count
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
  board.each_index.all? do |index|
    position_taken?(board, index)
  end 
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board) 
  winning_array = won?(board)
    if won?(board)
      if board.at(winning_array[0]) === "X"  
        return "X" 
      elsif board.at(winning_array[0]) === "O"
        return "O"
      end
    end
  return nil
end

def play(board)
  winning_array = won?(board)
  until over?(board)
    if current_player(board) == "X"
      if turn(board)
    elsif current_player(board) == "O"
      if turn(board)
    end
  end
  if won?(board)
    puts "Congrationlations #{board.at(winning_array[0])}!"
  elsif draw?(board)
    puts "The game was a draw."
  end
end