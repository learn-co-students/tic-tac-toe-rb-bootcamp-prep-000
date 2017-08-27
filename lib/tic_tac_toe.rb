WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # First column
  [1,4,7],  # Second column
  [2,5,8],  # Third column
  [0,4,8],  # First diagonal
  [2,4,6]   # Second diagonal
]
#Determines if game has been won
def won?(board)
  if empty?(board)
    return false
  end

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
    else
      false
    end
  end

  if full?(board)
    return false
  end
end

#Returns true if board is full
def full?(board)
  !board.detect{|i| i == " "}
end

#Returns true if board is empty
def empty?(board)
  !board.detect{|i| i == "X" || i == "O"}
end

#Determines if game has ended in a draw
def draw?(board)
  if full?(board)
    if !won?(board)
      return true
    else
      return false
    end
  end
end

#Returns true if the game is over
def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  else
    return false
  end
end

#Returns the winner of the game
def winner(board)
  if won?(board)
    winner = won?(board)
    return board[winner[0]]
  else
    return nil
  end
end

#Displays the current game board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Returns true if a given board position is taken
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

#Returns true if there the requested move is valid
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#Converts users input to index in board array
def input_to_index(user_input)
  index = user_input.to_i - 1
  return index
end

#Commits the move to the board array
def move(board, index, character)
  board[index] = character
  return board
end

#Initiates a turn by prompting for user input, and if valid, commiting the move
def turn(board)
  player = current_player(board)
  puts "Player #{player}, Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  is_valid = false
  until is_valid
    if valid_move?(board, index)
      move(board, index, player)
      display_board(board)
      is_valid = true
    else
      puts "Invalid Selection! Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
    end
  end
end

#Keeps track of the current turn
def turn_count(board)
current_turn = 0
board.each do |space|
  if space != " "
    current_turn += 1
  end
end
return current_turn
end

#Keeps track of the current player
def current_player(board)
  current_turn = turn_count(board)
  if current_turn == 0 || current_turn % 2 == 0
    return "X"
  else
    return "O"
  end
end

#Plays the game
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    winning_player = winner(board)
    puts "Congratulations #{winning_player}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
