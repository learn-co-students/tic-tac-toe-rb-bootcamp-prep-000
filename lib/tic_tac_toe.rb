def display_board(board)
  cells = []
  rows = []
  separater = "-----------" + "\n"
  board.length.times do |i|
    cells[i] = " #{board[i]} "
  end
  for i in 0..2
    rows[i] = "#{cells[3*i]}" + "|" + "#{cells[3*i + 1]}" + "|" + "#{cells[3*i + 2]}" + "\n"
  end
  print rows[0], separater, rows[1], separater, rows[2]
end

def input_to_index(input)
  index = input.to_i - 1
  return index
end

def move(board, index, character)
  board[index] = character
  return board
end


def valid_move?(board, index)
  if index.between?(0,8) && (!position_taken?(board, index))
    return TRUE
  else
    return FALSE
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" or board[index] || "O"
    return true
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all?{|i| (i == "X" || i == "O")}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def turn_count(board)
  turns = 0
  board.each do |square|
    if square == "X" || square == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end
end
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2],[3, 4, 5],[6, 7, 8],[0, 3, 6],[1, 4, 7],[2, 5, 8],[0, 4, 8],[2, 4, 6]]
