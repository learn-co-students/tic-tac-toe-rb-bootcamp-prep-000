def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4 ,6]
]

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
  return board
end

def valid_move?(board, index)
  if index.between?(0, 8)
    if !(position_taken?(board, index))
      return true
    end
  end
  return false
end

def turn(board)
  puts "Please enter 1-9:"
  turn = gets.strip
  index = input_to_index(turn)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |val|
    if !(val == " " || val == "")
      count += 1
    end
  end
    return count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  end
  return "O"
end

def won?(board)
  WIN_COMBINATIONS.any? do |combination|
    pos_0 = combination[0]
    pos_1 = combination[1]
    pos_2 = combination[2]
    val = board[pos_0]

    if val != " " && val != "" && board[pos_1] == val && board[pos_2] == val
      return combination
    end
  end
  return false
end

def full?(board)
  board.each do |val|
    if val == " " || val == ""
      return false
    end
  end
  return true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
  return false
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
  return false
end

def winner(board)
  combination = won?(board)  # Win combination or false.
  if combination
    return board[combination[0]]  # combination[0] would be a board position
                                  # where winner had made a move.
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
