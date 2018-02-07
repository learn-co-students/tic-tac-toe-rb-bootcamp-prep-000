WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [6,4,2], # Diagonal left bottom to right Top
  [0,4,8]  # Diagonal left top to right bottom
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# converts user input to board inde
def input_to_index(int)
  converted_integer = int.to_i - 1
end

# adds players X or O to their chosen position
def move(board, position, player_token)
  board[position] = player_token
end

# check if board position is empty or filled
def position_taken?(board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

# check if move is valid (within the board and not in a filled position)
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Process for one complete turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

# returns number of turns that have been played
def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  
  return count
end

# returns current player who needs to make next move
def current_player(board)
  count = turn_count(board)
  
  player = count.even? ? "X" : "O"
  
  return player
end

# returns combination of winning indexes. If no winner, returns nil
def won?(board)
  
  def winning_combo?(combination)
    combination.all? {|position| position == "X"} || combination.all? {|position| position == "O"}
  end
  
  WIN_COMBINATIONS.detect do |win_combination|
    # Get index for each winning combination
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    # Get board position at each winning index position
    # so we can compare
    board_position_1 = board[win_index_1]
    board_position_2 = board[win_index_2]
    board_position_3 = board[win_index_3]
    
    board_combination = [board_position_1, board_position_2, board_position_3]
    
    winning_combo?(board_combination)
  end
end

# Return false if there are any empty spaces
def full?(board)
  !board.include?(" ")
end

# Check if the board is full, but there are no winners
def draw?(board)
  !won?(board) && full?(board)
end

# Check if game is over (won, full board, or a draw)
def over?(board)
  won?(board) || full?(board) || draw?(board)
end

# returns if winner is "X" or "O"
def winner(board)
  if won?(board)
    win_combination = won?(board)
    
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    winning_positions = [board[win_index_1], board[win_index_2], board[win_index_3]]
    
    if winning_positions.all? {|position| position == "X"}
      return "X"
    elsif winning_positions.all? {|position| position == "O"}
      return "O"
    end
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