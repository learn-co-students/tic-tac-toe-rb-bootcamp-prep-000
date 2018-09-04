def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  if index > 8 || index < 0
    return false
  elsif position_taken?(board, index) == false 
    return true 
  else 
    return false
  end 
end

def input_to_index(string)
  index = string.to_i - 1 
end 

def move(board, index, char)
  board[index] = char
  return display_board(board)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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
  
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_combination
    end 
  end
  return false
end 

def full?(board)
  if board.include?(" ")
    false
  else 
    true 
  end 
end 

def draw?(board)
  if full?(board) && !won?(board)
      true
  else
    false
  end 
end 

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  index = won?(board)
  if over?(board) && won?(board)
    if board[index[0]].include?("X")
      "X"
    elsif board[index[0]].include?("O")
      "O"
    end 
  else
    nil
  end 
end 
    
def turn_count(board)
  count = 0 
  board.each do |space|
    if space != " "
      count += 1
    end 
  end 
  return count
end 

def current_player(board)
  count = turn_count(board)
  if count == 0 
    "X"
  elsif count % 2 == 0 
    "X"
  else 
    "O"
  end 
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

def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end 
end 