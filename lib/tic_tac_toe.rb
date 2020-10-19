# helper methods

# CONSTANT array of combinations to win
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

# display board with board data
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# makes player input (1-9) to zero index (0 - 8)
def input_to_index(user_input)
  user_input.to_i - 1
end

# assigns "X" or "O" to the indicated position
def move(board, index, player_char)
  board[index] = player_char
end

# check if position is empty or filled with "X" or "O"
# => taken : empty
def position_taken?(board, position)
  # checks for "X", "O", or a position not on board
  if board[position] == "X" || board[position] == "O"
    true
  else
    false
  end
end

# check if index is 0-8 and there isn't an "X" or "O" there already
def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0, 8) == true
    true
  else
    false
  end
end


# => number of turns that have been played
def turn_count(board)
  count = 0
  # check each spot in board arrays
  board.each do | slot |
    # if taken then add 1 to the count
    if slot == "X" || slot == "O"
      count += 1
    end
  end
  # return the count
  count
end

# determines if it is player X or O
def current_player(board)
  # if even the next move is "X"
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

# runs logic for compete turn
def turn(board)
  # ask user for move 1-9
  puts "Please Input Number 1-9: "
  # receive user input and assign to variable
  spot = gets.chomp
  # convert input to valid input
  index = input_to_index(spot)
  # if valid move
  if valid_move?(board, index) == true
    # make move
    player = current_player(board)
    move(board, index, player)
    # display new board with move
    display_board(board)
  else
    # run method again to ask for input
    turn(board)
  end
end


# check for win
def won?(board)
  # loop through arrays of WIN_COMBINATIONS
  WIN_COMBINATIONS.any? do | possible_win |
    # assign each element in array to variable to check
    position_1 = board[possible_win[0]]
    position_2 = board[possible_win[1]]
    position_3 = board[possible_win[2]]
    # if win combo filled with all "X" or "O" alert win
    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      # return winning positions
      return possible_win
    else
      false
    end
  end
end

# => all elements are "X" or "O"
def full?(board)
  # check that there are no empty spaces (valid move makes sure they are all X or O)
  board.none? do | spots |
    spots == " "
  end
end

# => board not won but full : board not full and not won | board is won
def draw?(board)
  # checks if board is full and no win combo has occured
  if full?(board) == true && won?(board) == false
    true
  end
end

# => won, draw, full
def over?(board)
  if won?(board) != false || full?(board) == true || draw?(board) == true
    true
  end
end

# return tolken of winner, "X" of "O"
def winner(board)
  # if won? => winning combination
  if won?(board) != false
    # assign array to winner_winner
    winner_winner = won?(board)
    # return what is in one of the winning positions
    return board[winner_winner[0]]
  end
end

# runs game loop
def play(board)
  # runs turn until full, draw, or win
  until over?(board) == true
    turn(board)
  end
  # if win => congratulates them
  if won?(board) != false
    # gets the winner "X" or "O"
    win_person = winner(board)
    puts "Congratulations #{win_person}!"
  # if it is a draw => puts Cat's Game!
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
