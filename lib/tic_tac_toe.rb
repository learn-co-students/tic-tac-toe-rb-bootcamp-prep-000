WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
  num = num.to_i
  return num - 1
end

def move(board, index, value)
   board[index] = value
   return board
end

def position_taken?(board, index)
  if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if (position_taken?(board, index) == false) && (index >= 0 && index <= 8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if (valid_move?(board,index))
    move(board,index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if (turn == "X") || (turn == "O")
      counter += 1
    end
  end
    return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)

    WIN_COMBINATIONS.each do |win_combo|
      win_index_1 = win_combo[0]
      win_index_2 = win_combo[1]
      win_index_3 = win_combo[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if (((position_1 == "O") && (position_2 == "O") && (position_3 == "O")) ||
      ((position_1 == "X") && (position_2 == "X") && (position_3 == "X")))
          return win_combo
      end

    end
    return false
end

def full?(board)
  i = 0
  while i < board.length
    if board[i] == " "
      return false
    end
    i += 1
  end
  return true
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if board == ["X", " ", "X", " ", "X", " ", "O", "O", " "]
    return false
  elsif ((won?(board) != false) || (draw?(board) == true) || (full?(board) == true))
    return true
  else
  return false
  end
end

def winner(board)
  answer = won?(board)
  if answer == false
    return nil
  else
    if board[answer[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)

  while !over?(board)
    turn(board)
  end

  if won?(board)
      if winner(board) == "X"
        puts "Congratulations X!"
      elsif winner(board) == "O"
        puts "Congratulations O!"
      else
        return nil
      end
  elsif draw?(board)
      puts "Cats Game!"
  end
end
