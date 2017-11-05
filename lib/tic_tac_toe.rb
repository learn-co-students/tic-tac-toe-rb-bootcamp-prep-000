WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") ||
       (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O")
      return combo
    end
  end
  return nil
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    win = won?(board)
    if board[win[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def display_board(board)
  result = ""
  divider = "-----------\n"
  result << " #{board[0]} | #{board[1]} | #{board[2]} \n"
  result << divider
  result << " #{board[3]} | #{board[4]} | #{board[5]} \n"
  result << divider
  result << " #{board[6]} | #{board[7]} | #{board[8]} \n"
  print result
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    true
  else
    false
  end
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |cell|
    if cell != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) == 0 || turn_count(board) % 2 == 0
    "X"
  else
    "O"
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
