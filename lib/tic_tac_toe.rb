WIN_COMBINATIONS = [
  [0, 1, 2], # horizontal top row
  [3, 4, 5], # horizontal middle row
  [6, 7, 8], # horizontal bottom row

  [0, 4, 8], # diagonal first row
  [2, 4, 6], # diagonal last row

  [0, 3, 6], # vertical left row
  [1, 4, 7], # vertical middle row
  [2, 5, 8]  # vertical right row
]

def display_board(board)
  i = 0
  while i < 9 do
    puts " #{board[i]} | #{board[i+1]} | #{board[i+2]} "
    if i < 6
      puts "-----------"
    end
    i += 3
  end
end

def input_to_index(input)
  return input.to_i - 1
end

def position_taken?(board, index)
  if !(board[index] == " ")
    return true
  end
  return false
end

def valid_move?(board, index)
  if !(position_taken?(board, index))
    # separated the two if's for code clarity
    if (!((board[index] == "X") || (board[index] == "O")) && (index >= 0 && index <= 8))
      return true
    end
  end
  return false
end

def move(board, index, char)
  if (valid_move?(board, index))
    board[index] = char
  end
end

def turn(board)
  puts "Please enter 1-9: "
  index = input_to_index(gets.strip.to_i)
  if !(index >= 0 && index <= 8)
    turn(board)
  else
    move(board, index, current_player(board))
  end
end

def turn_count(board)
  turn = 0
  board.each do |space|
    if space != " "
      turn += 1
    end
  end

  return turn
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  end

  return "O"
end

def won?(board)
  '''
  for each win_combination in WIN_COMBINATIONS
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination # return the win_combination indexes that won.
    else
      false
    end
  end
  '''

  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    # checking for x
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination # return the win_combination indexes that won.
    end

    # checking for o
    if position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    end
  end

  return false
end

def full?(board)
  board.each do |space|
    if space == " "
      return false
    end
  end

  return true
end

def draw?(board)
  if full?(board) && !(won?(board))
    return true
  end

  return false
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end

  return false
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo == false
    return nil
  end
  return board[winning_combo[0]]
end

def play(board)
  '''
  until the game is over
    take turns
  end

  if the game was won
    congratulate the winner
  else if the game was a draw
    tell the players it has been a draw
  end
  '''

  while !(over?(board)) do
    turn(board)
    display_board(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
