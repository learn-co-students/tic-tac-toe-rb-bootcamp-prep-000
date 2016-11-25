
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], # second row
  [6,7,8], #Third Row
  [0,3,6], #First Column
  [1,4,7], #Second Column
  [2,5,8], #Third Column
  [0,4,8], #diagonal left to right
  [2,4,6] #diagonal right to left
]

def display_board(board)


      puts " #{board[0]} | #{board[1]} | #{board[2]} "
      puts "-----------"
      puts " #{board[3]} | #{board[4]} | #{board[5]} "
      puts "-----------"
      puts " #{board[6]} | #{board[7]} | #{board[8]} "




end

#chnage user input to fit the array index(0-8 instead of 1-9)
def input_to_index(user_input)

    user_input.to_i - 1


end

def move(board, position, player_token)

    board[position] = player_token


end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)

      if position_taken?(board, index) == false && index.between?(0,8)
        true
      end
end

def turn(board)

  puts "Please enter 1-9:"
  turn_input = gets.strip.to_i
  if !turn_input.between?(1,9)
    turn(board)
  end
  index = input_to_index(turn_input)
  if valid_move?(board,index)
    if current_player(board) == "X"
      move(board,index,"X")
    else
      move(board,index,"O")
    end

    display_board(board)
  end
end

def turn_count(board)
  (board.select { |move| move == "X" || move == "O"}).length #count the length of the occupied board indexes which gives
                                                             #me the numbers of turn.
end

def current_player(board)

  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end

end

def won?(board)

  WIN_COMBINATIONS.each do |win_index|
    win_position_1 = win_index[0]
    win_position_2 = win_index[1]
    win_position_3 = win_index[2]

    if (board[win_position_1] == "X" && board[win_position_2] == "X" && board[win_position_3] == "X") || (board[win_position_1] == "O" && board[win_position_2] == "O" && board[win_position_3] == "O")
      return win_index
    else
      false
    end

  end

  false
end

def full?(board)
  board.all? { |move| move == "X" || move == "O"}

end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end

end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end


end

def winner(board)
  if won?(board)
    position_1 = won?(board)[0]
    board[position_1]
  else
    nil
  end

end

def play(board)



    until over?(board)
      turn(board)


    end


  if winner(board) == "X"

    puts "Congratulations X!"
  else
    puts "Congratulations O!"
  end

  if draw?(board)
    puts "Cats Game!"
  end

end
