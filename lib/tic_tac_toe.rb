# THIS PASSES ALL THE TESTS ...

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [0,4,8],  # Diaonal 1
  [2,4,6]  # Diagonal 2
]

def empty?(board)
    board.all? { |pos| (pos.nil? || pos == " " || pos == ""  )} # if these are always true, the board is empty, return true
end

def won?(board)
  winner = false
  pos_winners = []
  return false if empty?(board)  # Nice Short-Cut!!

  pos_winners = []
  WIN_COMBINATIONS.each do |win_combo|  
      all_3_taken = false

      all_3_taken = win_combo.all? do |index|   
        position_taken?(board, index)       # true if all indexes are occupied.
      end
      if all_3_taken 
        pos_winners.push(win_combo)
      end
  end  # WIN_COMBINATIONS.each loop end  
  
  # Now have an array with the possible winners ...  
    if pos_winners.length == 0   # no winner, BAIL
      return pos_winners[98]  # returning nil, duh. 
    end

  # Now see if any pos_winner is "ALL THE SAME" and return it.  
  winning_combo = false
  pos_winners.each do |pos_combo|
    if 
      (board[pos_combo[0]] == board[pos_combo[1]]) && (board[pos_combo[0]] == board[pos_combo[2]])
      winning_combo = pos_combo
    end  
  end # pos_winners each loop
  return winning_combo
end  # this is the won? function end

def full?(board)
  board.none? {|this_pos| (this_pos.nil? || this_pos == " " || this_pos == "")} 
end

def draw?(board)
  if full?(board)
    return true if !(won?(board)) && full?(board)
    return false if !(won?(board)) && !(full?(board))
    return false if won?(board)
  end  
end

def over?(board)
  if full?(board) ||  won?(board)  #returns true for a WIN OR Dra
    return true
  end
  return false
end

def winner(board)
  if won?(board)
    win_combo = won?(board)
    winner = board[win_combo[0]]   #The first value will be "X" or "O" - the WINNER!
    return winner
  end
end  

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!

def input_to_index(input)
  input = input.to_i
  index = input - 1
  return index
end  

def update_array_at_with(board, index, value)
  index = index.to_i
  board[index] = value
  return board
end

def move(board, index, value)
  index = index.to_i
  new_board = update_array_at_with(board, index, value)
  display_board(new_board)
end

def valid_move?(board, i)
  # check if position taken or 'out-of-bounds'
  if (position_taken?(board, i) == true) || (i > 8) || (i < 0)
    return false
  else 
    return true
  end  
end 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  if valid_move?(board, index)
    move(board, index, value)
    return index
  else
    turn(board)
  end  
end  

def turn_count(board)
  count = 0
  board.each do |value|
    if ("#{value}" == "X") ||  ("#{value}" == "O")
      count += 1
    end
  end
  return count
end 

def current_player(board)
  count = turn_count(board)
  if count == 0
    return "X" 
  elsif 
    count % 2 == 0  # it's even so "X" plays next...
    return "X"
  else 
    return "O"
  end 
end

def play(board)
  until over?(board) || draw?(board)
    current_player(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end  


=begin
def play(board)
  num_of_turns = 0
  while num_of_turns > 10

    unless over?(board)
      turn(board)
    end
    
    # checks if the game is a win or draw after every turn
    if won?(board)
      puts "Congratulations " + winner(board) +"!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
  num_of_turns += 1
end
=end

