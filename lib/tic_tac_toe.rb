WIN_COMBINATIONS = [
  [0, 1, 2],  # Top row 
  [3, 4, 5],  # Middle row 
  [6, 7, 8],  # Bottom row
  [0, 3, 6],  # Left column
  [1, 4, 7],  # Middle column
  [2, 5, 8],  # Right colum
  [0, 4, 8],  # Across (left to right)
  [2, 4, 6]   # Across (right to left)
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

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0 
  index = 0
  board.each do |position|
    count += 1 if position_taken?(board, index) 
    index += 1 
  end
  count 
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]
      
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
        
  if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O") 
        return combination
    end 
  end
  return false
end 

def full?(board)
  board.all? do |position|
    position != " " && position != "" && position != nil
  end
end 

def draw?(board)
  full?(board) && !won?(board)
end
  
def over?(board)
  won?(board) || draw?(board)
end
  
def winner(board)
  winner = won?(board)
  winner ? board[winner[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) 
    puts "Congratulations #{winner(board)}!" 
  else 
    puts "Cat's Game!"
  end 
end
  
  
  
  
  
  
  
  