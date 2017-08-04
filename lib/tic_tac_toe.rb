#DEFINE WIN COMBINATIONS

WIN_COMBINATIONS =
[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

#DISPLAY_BOARD

def display_board(board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

#INPUT_TO_INDEX

def input_to_index(arg)
  return arg.to_i - 1
end

#MOVE

def move(array, index, value)
  array[index] = value
end

#POSITION_TAKEN

def position_taken?(board, index)

  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

#VALID_MOVE

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#TURN

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

#TURNCOUNT

def turn_count(board)
  #set counter variable
  counter = 0
  #iterate through board, looking for number of plays, if found, increase counter variable
  board.each do |play|
    if play == "X" || play == "O"
      counter += 1
    end
  end
  return counter
end

#CURRENT_PLAYER

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

#WON

def won?(board)

    #for each win_combination in WIN_COMBINATIONS

    WIN_COMBINATIONS.detect do |win_combination|

    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win, and load the value of the board at position x

    position_1 = board[win_combination[0]] # load the value of the board at win_index_1
    position_2 = board[win_combination[1]] # load the value of the board at win_index_2
    position_3 = board[win_combination[2]] # load the value of the board at win_index_3

    position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_combination[0])
  end
end

#FULL

def full?(board)
  !board.include?(' ')
end

#DRAW

def draw?(board)
  !won?(board) && full?(board)
end

#OVER

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

#WINNER

def winner(board)
  if won?(board)
      board[won?(board)[0]]
  end
end


#PLAY

def play(board)

#  until the game is over
  until over?(board)
#    take turns
    turn(board)
  end


#  if the game was won
  if won?(board)
#    congratulate the winner
    puts "Congratulations #{winner(board)}!"
#  else if the game was a draw
  elsif draw?(board)
#    tell the players it has been a draw
    puts "Cats Game!"
  end

end
