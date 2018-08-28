
def valid_move?(board, index)
  
  if(position_taken?(board,index))
    return false;
  elsif(index.between?(0,8))
    return true;
  end
  
end


def position_taken?(board, index)
  if(board[index] === " " || board[index] ==="" || board[index] === nil)
    return false
  elsif(board[index] ==="X" || board[index] ==="O")
  return true
  end
end


WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  ]

def display_board(board_string)
  puts " #{board_string[0]} | #{board_string[1]} | #{board_string[2]} "
  print_line_row
  puts " #{board_string[3]} | #{board_string[4]} | #{board_string[5]} "
  print_line_row
  puts " #{board_string[6]} | #{board_string[7]} | #{board_string[8]} "
end

def print_line_row()
  
  puts "-----------"
  
end

def input_to_index(input)
  input_i = input.to_i
  input_i = input_i - 1
end

def move(board,index,player)
  
  board[index] = player
  
  #return modified array
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

def play(board)
  turn_count = 1
  while (turn_count <= 9 && !(over?(board)))
    turn(board)
    turn_count += 1
  end
  
  if(draw?(board))
    puts "Cat's Game!"
  elsif(won?(board))
    puts "Congratulations #{winner(board)}!"
  end
end

def turn_count(board)
  turns_taken = 0
  
  board.each do |index|
    if(index == "X" || index == "O")
      turns_taken += 1
    end
    
  end
  
    return turns_taken
  
end

def current_player(board)
    turn = turn_count(board)
    
    if(turn % 2 == 0)
      return "X"
    else
      return "O"
    end
    
end


def won?(board)
  
  WIN_COMBINATIONS.detect do |element|
    if (board[element[0]] == "X" && board[element[1]] == "X" && board[element[2]] == "X")
      true
    elsif(board[element[0]] == "O" && board[element[1]] == "O" && board[element[2]] == "O")
      true
    else
      false
    end
  end
end

def full?(board)
  counter = -1
  board.all? do |element|
    counter += 1
    position_taken?(board,counter)
  end
end

def draw?(board)
  
  if(won?(board))
    return false
  elsif(full?(board))
    return true
  else
    return false
  end
end

def over?(board)
  
  if(won?(board))
    return true
  elsif(draw?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if(check = won?(board))
    return board[check[0]]
  end
end