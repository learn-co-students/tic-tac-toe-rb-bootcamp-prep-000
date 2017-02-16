# Define WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],  #Top row
  [3,4,5],  #Middle row
  [6,7,8],  #Bottom row
  [0,3,6],  #First column
  [1,4,7],  #Second column
  [2,5,8],  #Third column
  [0,4,8],  #First diagonal
  [2,4,6]   #Second diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#convert user input to array index
def input_to_index(player_move)
  num = player_move.to_i - 1
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

#takes board, index and the character to place a move on the board
def move(board, index, character)
  board[index] = character
  board
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == true
    false
  elsif !index.between?(0,8)
    false
  else
    true
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

def turn_count(board)
  counter = 0

  board.each do |square|
    if square != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    current = "X"
  else
    current = "O"
  end
end

def won?(board)
#for each win_combination in WIN_COMBINATIONS grab each index from the
#win_combination that composes a win.
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    #return the win_combination indexes that won.
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  #return false or nil if there is no winning combination
  false
end

def full?(board)
  #if no empty spaces return true
  !board.include? " "
end

def draw?(board)
  #returns true if the board has not been won and is full
  if !won?(board) && full?(board)
    true
  #returns false if the board is won
  else
    false
  end
end

def over?(board)
  #returns true if the board has been won, is a draw, or is full
  if won?(board) || draw?(board) || full?(board)
    true
  end
end

def winner(board)
  #call won for the winning combination
  if winning_combo = won?(board)
    #match winning combo against the board
    #winner = winning_combo[0]
    board[winning_combo[0]]
  end
end
