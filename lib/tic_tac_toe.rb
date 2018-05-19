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

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (input)
  return input.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if (index.between?(0, 8) && !position_taken?(board, index))
    return true
  end
  return false
end

def move(board, index, value)
  board[index] = value
  return board
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.to_s.strip
  index = input_to_index(input)
  if (valid_move?(board, index))
    board = move(board, index, current_player(board))
  else
    puts "Invalid move!"
    return turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each do |pos|
    if (pos == "X" || pos == "O")
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |wincombo|
    win_index_1 = wincombo[0]
    win_index_2 = wincombo[1]
    win_index_3 = wincombo[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return wincombo
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return wincombo
    end
  end
  return false
end

def full?(board)
  return board.all? {|pos| pos == "X" || pos == "O"}
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  end
  return false
end

def over?(board)
  if (won?(board) || full?(board))
    return true
  end
  return false
end

def winner(board)
  if (won?(board))
    winner = board[won?(board)[0]]
    return winner
  end
end

def play(board)
  until(over?(board) || draw?(board))
    turn(board)
  end
  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end