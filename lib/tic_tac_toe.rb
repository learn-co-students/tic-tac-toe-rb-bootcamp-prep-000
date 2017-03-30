WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  row1 = " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  row2 = " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  row3 = " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
  dashes = "-----------"
  puts row1
  puts dashes
  puts row2
  puts dashes
  puts row3
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
  board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8)
    if position_taken?(board, index)
      return false
    else
      return true
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
    count += 1 if pos == "X" || pos == "O"
   end
  count
end

def current_player(board)
  tally = turn_count(board)
  tally % 2 == 0  ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |el|
    pos1 = board[el[0]]
    pos2 = board[el[1]]
    pos3 = board[el[2]]
    if (pos1 == "X" && pos2 == "X" && pos3 == "X") || (pos1 == "O" && pos2 == "O" && pos3 == "O")
      return el
    end
  end
  return false
end

def full?(board)
  board.all? do |el|
    position_taken?(board, board.index(el))
  end
end

def draw?(board)
  result_won = won?(board)
  if full?(board) && result_won == false
    true
  else
    false
  end
end

def over?(board)
  won?(board) || draw?(board) ? true : false
end

def winner(board)
  if won?(board)
    arr = won?(board)
    winning = board[arr[0]]
    return winning
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
  elsif draw?(board)
    puts "Cats Game!"
  end
end
