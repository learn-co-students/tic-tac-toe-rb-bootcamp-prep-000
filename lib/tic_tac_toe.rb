

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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i
  index = index - 1
end

def move(board, index, character)
  board[index] = character
  return board
end

def position_taken?(array, index)
  if array[index] == " "
    return false
  elsif array[index] == ""
    return false
  elsif array[index] == nil
    return false
  elsif array[index] == "X" || array[index] == "O"
    return true
  end
end

def valid_move?(array, index)
  if index.between?(0, 8) && position_taken?(array, index) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index) == true && current_player(board) == "X"
    move(board, index, "X")
    display_board(board)
  elsif valid_move?(board, index) == true && current_player(board) == "O"
    move(board, index, "O")
    display_board(board)
  else
    puts("Please enter a valid number")
    turn(board)
  end
end

def turn_count(board)
  turn_number = 0
  board.each do |space|
    if space == "X"
      turn_number += 1
    elsif space == "O"
      turn_number += 1
    end
  end
  return turn_number
  end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 != 0
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |wc|
    win_index_1 = wc[0]
    win_index_2 = wc[1]
    win_index_3 = wc[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return wc # return the wc indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return wc
    end
  end
  return false
end

def full?(board)
  board.none? {|space| space == " "}
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) == true
    return true
  elsif won?(board) != false
    return true
  else
    return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |wc|
    win_index_1 = wc[0]
    win_index_2 = wc[1]
    win_index_3 = wc[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"
    end
  end
  return nil
end

def play(board)
  until over?(board) == true
  turn(board)
  end

  if draw?(board) == true
    puts("Cats Game!")
  elsif winner(board) == "X"
    puts("Congratulations X!")
  elsif winner(board) == "O"
    puts("Congratulations O!")
  end
end
