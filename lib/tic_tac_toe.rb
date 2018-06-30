WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal 1 (negative slope)
  [2,4,6]  # Diagonal 2 (positive slope)
]

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player_character)
  board[index] = player_character
end

def position_taken? (board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
end

def turn_count(board)
  turns_played = 0
  
  board.each do |token|
    if token == "X" || token == "O"
      turns_played += 1 
    end
  end
  turns_played
end

def current_player(board)
  turn_count(board).even? ? "X" : "O" # It may be better to use %, to avoid two ?'s
end

def turn(board)
  puts "Please enter a number between 1 and 9:"
  input = gets.strip
  index = input_to_index(input)
  
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Sorry. Invalid move. Please try again."
    turn(board)
  end
end

def won?(board) # The Tic Tac Toe Game Status lab has a more elegant Solution
  WIN_COMBINATIONS.find do |win_combination|
    # Find the first win combination corresponding to all X's or all O's
    
    all_x = win_combination.all? do |win_index|
      board[win_index] == "X" # Is the board token an X at all three win indexes?
    end
    
    all_o = win_combination.all? do |win_index|
      board[win_index] == "O"
    end
    
    all_x || all_o # Return the all_x or all_o win combo, or null otherwise.
  end
  # nil if no win combination was found
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  # Returns "X" or "O" depending on the winner.
  # Returns nil if winning_player is nil.
  
  winning_player = won?(board) # This is either nil, or it's a win combination.
  
  if winning_player
    board[winning_player[0]]
    # winning_player[0] is the win combination's first index, 
    # corresponding to a position on the board.
    # This returns the winning token at that position.
  end
end