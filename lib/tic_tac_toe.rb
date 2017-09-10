WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  (user_input.to_i) - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if ((board[index] == " ") || (board[index] == "") || (board[index] == nil))
    false
  else
    true
  end
end

def valid_move?(board, position)
  if ((position <= 8) && (position != -1) && position_taken?(board, position) == false)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index) == true
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |entry|
    if entry == "X" || entry == "O"
      turns += 1
    end
  end
  turns
end


def current_player(board)
turns = turn_count(board)
  turns % 2 == 0 ? "X" : "O"
end

def won?(board)
  #If the board is empty, return false and skip the rest of the method
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  end
  #Iterate each winning combination and test if the three positions are all X or O
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
      (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  #If the win_combinations iteration ends up completely iterating through
  #without returning any winning combinations, I assumed it was a draw
  #and I return false upon completion of the iteration
  return false
end


def full?(board)
  board.all? do |symbol|
    symbol == "X" || symbol == "O"
  end
end

#If full?(board) is true and if won?(board) == false is true, the expression evaluates true
#If full?(board) is false and won?(board) == false is true, the expression is false
#If won?(board) == false is false (ie someone wins), the if statement is false
#Only way to get a draw is if the board is full and there is no winner (in the if statement)
def draw?(board)
  if full?(board) && (won?(board) == false)
    return true
  else
    return false
  end
end


def over?(board)
  if full?(board)|| draw?(board) || won?(board) != false
    return true
  else
    return false
  end
end


def winner(board)
  if won?(board) != false
    win_combination = won?(board)
    if board[win_combination[0]] == "X"
      return "X"
    elsif board[win_combination[0]] == "O"
      return "O"
    end
  else
    return nil
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
