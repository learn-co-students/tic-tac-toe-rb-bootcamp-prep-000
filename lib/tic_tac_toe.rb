board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

puts "Welcome to Tic Tac Toe!"


# Displays the values of board array
def display_board(board_current)
  puts " #{board_current[0]} | #{board_current[1]} | #{board_current[2]} "
  puts "-----------"
  puts " #{board_current[3]} | #{board_current[4]} | #{board_current[5]} "
  puts "-----------"
  puts " #{board_current[6]} | #{board_current[7]} | #{board_current[8]} "
end

#Converts User input for Use in arrays
def input_to_index(user_input)
  user_input.to_i - 1
end

# Checks if the index is within range of 0-8 and has either O or X
def valid_move?(board, index)
  if (0..8) === index
    if board[index] === "O" || board[index] === "X"
      return false
    else
      return true
    end
  else 
    return false
  end
end

# Checks if the index in the array is occupied
def position_taken?(board, index)
  if board[index] === "O" || board[index] === "X"
    return true
  elsif board[index] == ' '
    return false
  end
end

# Place x or o based on input
def move(array, index, token)
  return array.map{ |x| array[index]= token}
end

# Asks for input, gets, then converts
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  
  if valid_move?(board, index)
    return move(board, index, current_player(board)), display_board(board)
  else
    return turn(board)
  end
end

# Sets a counter for turn number
def turn_count(board)
  i = 0
  board.each do |x|
    if x == 'X' || x == 'O'
      i += 1
    end
  end
  
  return i
end

# Sets Current Player, X/O
def current_player(board)
  turn = turn_count(board).even? ? "X" : "O"
end

# Checks if a player won the game
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination # return the win_combination indexes that won.
    end
  end
  return false # If you leave in the do loop above, it forces a false return.
end

# Checks if given board array is full
def full?(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    else
      return false
    end
  end
  if counter == 9
    return true
  end
end

# Checks if there is a draw
def draw?(board)
  if full?(board) && !(won?(board))
      return true
  else
      return false
  end
end

# Checks if the game is over
def over?(board)
  if draw?(board) || full?(board) || won?(board)
      return true
  else
      return false
  end
end
 
# Checks who the winner is 
def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return "X" # return the Token that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return "O"  # return the Token that won.
    end
  end
  return nil # If you leave in the do loop above, it forces a false return.
end

# Plays game
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

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  # Row Wins
  [0, 1, 2],  # Top row
  [3, 4, 5],  # Middle row
  [6, 7, 8],  # Bottom Row

  # Column Wins
  [0, 3, 6],  # First Column
  [1, 4, 7],  # Second Column
  [2, 5, 8],  # Third Column

  # Diagonal Wins
  [0, 4, 8],  # Top Left to Bottom Right
  [2, 4, 6]   # Top Right to Bottom Left
]



