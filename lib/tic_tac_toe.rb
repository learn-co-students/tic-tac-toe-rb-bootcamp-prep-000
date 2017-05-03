def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(n)
  index = n.to_i - 1
end

def move(board, index, symbol)
  board[index] = symbol
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8)
    if position_taken?(board, index) == false
      return true
    end
  end
  false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  while valid_move?(board, index) == false
    return turn(board)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def play(board)
  while(!over?(board))
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end

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

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    if (board[comb[0]] == "X" && board[comb[1]] == "X" && board[comb[2]] == "X") ||
      (board[comb[0]] == "O" && board[comb[1]] == "O" && board[comb[2]] == "O")
      return comb
    end
  end
      return false
end

def full?(board)
  i = 0
  while i < 9
    if !position_taken?(board, i)
      return false
    end
    i += 1
  end
return true
end

def draw? (board)
   !won?(board) && full?(board)
end

def over? (board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
  end
end

def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
    if turn_count(board) % 2 == 0 || turn_count(board) == 0
    return "X"
  end
else return "O"
end
