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
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

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

def turn_count(board)
  counter = 0
  board.each do |space|
    if ("#{space}" == "X" || "#{space}" == "O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if (turn_count(board).even?)
    "X"
  else
    "O"
  end
end

def won?(board)
  win = nil
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if ((position_1 == "X" && position_2 == "X" and position_3 == "X") || (position_1 == "O" && position_2 == "O" and position_3 == "O"))
      win = [win_index_1, win_index_2, win_index_3]
      return win
    end
  end
  if (win == nil)
    false
  end
end

def full?(board)
  board.none?{|location| location == " "}
end

def draw?(board)
  if (!won?(board) && full?(board))
    true
  end
end

def over?(board)
 if (won?(board) || full?(board) || draw?(board))
   true
 end
end

def winner(board)
 if (won?(board))
   index = won?(board)[1]
   return board[index]
 end
end

def play(board)
  until(over?(board))
    turn(board)
  end
  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif (full?(board))
    puts "Cat's Game!"
  end
end
