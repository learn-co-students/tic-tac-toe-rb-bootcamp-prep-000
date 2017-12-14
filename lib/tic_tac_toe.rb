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

def display_board(
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts 'display board'
#board output
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

 def input_to_index(input)
   index = input.to_i - 1
 end

 def move(board, index, char)
  board[index] = char
 end

 def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8)  && position_taken?(board, index) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
    else
      turn(board)
  end
end

def turn_count(board) # method takes board input/argument
  counter = 0 # no turn taken before start counting, ie start at 0
  board.each do |index| # Check each position index for "X" or "O"
    if index == "X" || index == "O" # If has an "X" or "O", a turn has been taken
      counter += 1 # so add 1 to the turn counter
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) == 0 #if no turns have been taken then
    return "X" # it is X turn
  elsif turn_count(board) % 2 == 0 #if even number of turns already taken,
    return "X" # then it is now X's turn
  else
    return "O" # if even number of turns already taken, then it is now O's turn
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo| # check each win combo by index
    x_win = win_combo.all? do |index| # to see if all values at that index
      board[index] == "X" # are "X"
    end
    o_win = win_combo.all? do |index| # to see if all values at that index
      board[index] == "O" # are "O"
    end
    if x_win || o_win
      return win_combo
    end
  end
  false
end

def full?(board) # board filled up?
  board.none?{|index| index == " " || index == nil} # No empty spaces?
end

def draw?(board) # cat's game
  !won?(board) && full?(board) # board both full and no winning combination
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  else
    return "O"
  end
end

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
