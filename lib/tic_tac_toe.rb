# Forms of different win conditions
WIN_COMBINATIONS = [
  #horizontal rows
  [0,1,2],
  [3,4,5],
  [6,7,8],
  
  #diagonall rows
  [0,4,8],
  [2,4,6],
  
  #vertical rows
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]

#Displays the game board
def display_board(board)
  
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  
end

#Change the input in to a valid index
def input_to_index(index)
  return (index.to_i - 1)
end

#Places the move on to the board and updates it
def move(board, position, player)
  board[position] = player
  return board
end

#Methods to check move validy and input moves on to board
#Checks if the position on the board is taken
def position_taken?(board, index)

  if (board[index] == " " || board[index] == "")
    return FALSE
  
  elsif (board[index] == nil)
    return FALSE
    
  elsif (board[index] == "X" || board[index] == "O")
    return TRUE
  
  else
    return TRUE
  
  end
end

#Checks if the inputted move is valid
def valid_move?(board, index)
  if (index > 8 || index < 0)
    return FALSE
    
  elsif (position_taken?(board, index) == TRUE)
    return FALSE
    
  else 
    return TRUE
  end
end


#Methods to check turns and current player
#Keeping track of turns
def turn_count(board)
  num_turns = 0
  board.each do |player|
    if (player == "X" || player == "O")
      num_turns += 1
    end
  end
  return num_turns
end

#Checking who the current player is
def current_player(board)
  turn_amt = turn_count(board)
  
  if (turn_amt%2 == 0)
    return "X"
  
  else
    return "O"
  
  end
end
  
# Win condition functions below
  
#Check for a winning combination
def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      return win_combination
    end
  end
  return FALSE
end

#Check to see if the board is full
def full?(board)
  board.each do |position|
    if (position == "" || position == " ")
      return FALSE
    end
  end
  return TRUE
end 

#Detect if a game is in a draw
def draw?(board)
  if (full?(board) == TRUE && won?(board) == FALSE)
    return TRUE
  else
    return FALSE
  end
end

#Detect if a game is over
def over?(board)
  if (won?(board) != FALSE)
    return TRUE
    
  elsif (draw?(board) == TRUE)
    return TRUE
    
  elsif (full?(board) == TRUE)
    return TRUE
  
  else 
    return FALSE
  end
end
  
#Check which player is the winner
def winner(board)
  
  if (won?(board) == FALSE)
    return NIL
  end
  
  winning_combination = won?(board)
  win_player = board[winning_combination[0]]
  
  if (win_player == "X")
    return "X"
  else 
    return "O"
  end
end 

#Function for to use for each turn of the Game
def turn(board)
  #Step 1: Request Input
   puts "Please enter 1-9: "
    chosen_position = gets.chomp
  
    chosen_position = input_to_index(chosen_position)
  
  #Check if the move is valid, if not, loop until valid move is placed
    while valid_move?(board, chosen_position.to_i) == FALSE
      puts "Please enter 1-9: "
        chosen_position = gets.chomp
        chosen_position = input_to_index(chosen_position)
    end
    
  #Step 2: Once input is valid, place the move in the board
  move(board, chosen_position, current_player(board))
  display_board(board)
end

def play(board)
  while over?(board) != TRUE
    turn(board)
  end
  
  display_board(board)
  
  if (won?(board) != FALSE)
    puts "Congratulations #{winner(board)}!"
    
  else
    puts "Cat's Game!"
  end
    
end


