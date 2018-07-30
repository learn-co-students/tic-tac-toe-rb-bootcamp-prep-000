WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
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

def move(board, input, char)
  board[input] = char
end

def position_taken?(board, index)
  if board[index] == " " ||  board[index] == "" ||  board[index] == nil
      return false
  elsif board[index] == "X" ||  board[index] == "O"
     return true
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    return true
  end
end

def turn(board) 
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index) == true 
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0 
  board.each do |input| 
    if input == "X" || input =="O"
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
  WIN_COMBINATIONS.each do |win_combination| 
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
end
 


def full?(board)
  board.none? {|input| input == "" || input == " "}
end


def draw?(board)
  if !won?(board) && full?(board)
    return true 
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    puts board[won?(board)[0]] 
    return board[won?(board)[0]] 
  else return nil
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