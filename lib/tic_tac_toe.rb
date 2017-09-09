# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
  [0, 4, 8], # left-right diag
  [2, 4, 6]  # right left diag
]

# Display Tic Tac Toe board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Convert user input into an integer
def input_to_index(user_input)
  user_input.to_i - 1
end

# Update the board, simulates a player "move"
def move(board, index, current_player)
  board[index] = current_player
end

# Is this space free? true or false
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# Is the user input value valid? Is it on the board? Is it already taken?
def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    true
  else
    false
  end
end

# Simulates a turn, takes user input
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  elsif !valid_move?(board, index)
    turn(board)
  end
end

# Return the current turn number
def turn_count(board)
  turn = 0
  board.each do |character|
    if character == "X" || character == "O"
      turn += 1
    end
  end
  return turn
end


# Which player's turn is it? X or O
def current_player(board)
  turn = turn_count(board)
  if turn % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Has someone won?
def won?(board)

  WIN_COMBINATIONS.each do |combo| # iterate over each win combo
    pos_0 = board[combo[0]] # store board values in corresponding win combo indices
    pos_1 = board[combo[1]]
    pos_2 = board[combo[2]]
    if position_taken?(board, combo[0]) && pos_0 == pos_1 && pos_1 == pos_2
      return combo
    end
  end # end .each
  false
end # end def

# Is the board full?
def full?(board)
  board.all? do |character|
    character == "X" || character == "O"
  end
end

# Did the game end in a draw?
def draw?(board)
 full?(board) && !won?(board)
end

# Is the game over?
def over?(board)
  won?(board) || full?(board)
end

# Who is the winner?
def winner(board)
  if combo = won?(board)
    char = board[combo[0]]
    return char
  elsif draw?(board) || !over?(board)
    return nil
  end
end


# Primary game method, allows the game to be "played"
def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if won?(board)
     puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
