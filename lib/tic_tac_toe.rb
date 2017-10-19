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

def display_board(board)
  separator = "-" * 11
  counter = 0
  x = -1

  while counter < 5
    if counter.odd?
      puts separator
    else
      puts " #{board[x += 1]} | #{board[x += 1]} | #{board[x += 1]} "
    end
    counter += 1
  end
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  !(index < 0 || index > board.size || position_taken?(board, index))
end

def turn(board)
  puts "Where would you like to move [1-9]? "
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  played = board.reject {|i| i == " "}
  played.size
end

def current_player(board)
  if turn_count(board) % 2 == 0
    player = "X"
  else
    player = "O"
  end
  player
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    x, y, z = combo
    line = [board[x], board[y], board[z]]
    if line.all? {|i| i == "X"}
      return "X"
    elsif line.all? {|i| i == "O"}
      return "O"
    end
  end
  return nil
end

def full?(board)
  board.all? {|i| i != " "}
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  (won?(board) || full?(board) || draw?(board))
end

def winner(board)
  return won?(board)
end

def play(board)
  until over?(board)
    display_board(board)
    turn(board)
  end
  if winner(board)
    display_board(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
