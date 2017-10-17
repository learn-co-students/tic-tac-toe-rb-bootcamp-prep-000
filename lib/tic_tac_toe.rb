WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6],
  [0, 4, 8]
]


def display_board(board)
  puts " #{board[0]} " + "| #{board[1]} |" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "| #{board[4]} |" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "| #{board[7]} |" + " #{board[8]} "
end


def input_to_index(input)
  input.to_i - 1
end


def move(board, index, value)
  board[index] = value
  return board
end


def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end


def valid_move?(board, index)
 if position_taken?(board, index)
   return false
 elsif index.between?(0,8)
   return true
 else
   return false
 end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "That was an invalid move"
     turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X"
      counter += 1
    elsif token == "O"
      counter += 1
    end
  end
  return counter
end


def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.any? do |win_combination|
    if board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X" || board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O"
      return win_combination
    else
      false
    end
  end
end


def full?(board)
  board.each do |index|
    if index == "X" || index == "O"
      true
    else
      return false
    end
  end
end


def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end


def winner(board)
  winner = won?(board)
  if winner == false
    return nil
  elsif board[winner[0]] == "X" && board[winner[1]] == "X" && board[winner[2]] == "X"
    return "X"
  elsif board[winner[0]] == "O" && board[winner[1]] == "O" && board[winner[2]] == "O"
    return "O"
  end
end


def play(board)
  while !over?(board) do
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
