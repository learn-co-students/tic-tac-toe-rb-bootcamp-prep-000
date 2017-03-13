
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player )
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count( board )

  myCounter = 0
  board.each do |myXO|
    if myXO == "X" || myXO == "O"
      myCounter += 1
    end
   end

   return myCounter
end


def current_player( board )

  # If turn_count is EVEN then return X
  turnCount = turn_count( board )

  if turnCount.even?
    return "X"
  else
    return "O"
  end

end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board) )
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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

def won?( board )
  # Return indexes if there is a win, otherwise nil
  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
       (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination # return the win_combination indexes that won.
    end

  end  # do end

  return nil

end  # won end

def full?( board )
  return !board.detect{|i| i==" "}
end

def draw?( board )
  # draw? expects false from won? however winner? expexcts nil
  playerWon = won?(board)
  if playerWon == nil
    playerWon = false
  end

  boardFull = full?(board)

  if (playerWon == false) && (boardFull == true)
    return true
  elsif (playerWon == false) && (boardFull == false)
    return false
  elsif playerWon == true
    return false
  end

  return false
end  # End draw

def over?( board )

  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end

end

def winner( board )

  myWinner = won?(board)

  if myWinner == nil
    return myWinner
  end

  return board[myWinner[0]]

end

def play( board )

  until over?( board )
    turn( board )
  end

  if winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end

end  # End of play
