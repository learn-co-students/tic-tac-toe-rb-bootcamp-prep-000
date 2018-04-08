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
  rows = [" #{board[0]} | #{board[1]} | #{board[2]} ",
  "-----------",
  " #{board[3]} | #{board[4]} | #{board[5]} ",
  "-----------",
  " #{board[6]} | #{board[7]} | #{board[8]} "]
  puts rows[0]
  puts rows[1]
  puts rows[2]
  puts rows[3]
  puts rows[4]
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, index, token)
  puts board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index >= 0 && index <=8 && board[index] == " "
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  x = input_to_index(input)
  if valid_move?(board, x)
    move(board, x, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2 != 0 ? "O" : "X"
end

def won?(board)
  WIN_COMBINATIONS.select do |combo|
    i = combo[0]
    j = combo[1]
    k = combo[2]

    p1 = board[i]
    p2 = board[j]
    p3 = board[k]

    if p1 == "X" && p2 == "X" && p3 == "X"
      return combo
    elsif p1 == "O" && p2 == "O" && p3 == "O"
      return combo
    end
  end

  if board.all?{|space| space == " "}
    return false
  elsif board.none?{|space| space == " "}
    return false
  end
end

def full?(board)
  if board.any?{|space| space == " "}
    return false
  else
    return true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
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
  if won?(board)
    index = won?(board)[0]
    token = board[index]
    return token
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
