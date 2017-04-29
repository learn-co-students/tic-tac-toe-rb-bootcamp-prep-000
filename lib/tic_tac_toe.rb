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

def input_to_index(input)
  return input.to_i - 1
end

def move(board, input, player)
  board[input] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  return !(position_taken?(board, index)) && index >= 0 && index <= 8
end

def turn(board)
  puts "Please enter 1-9:"
  key = input_to_index(gets.strip)
  if valid_move?(board, key)
    move(board, key, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count {|x| x == "X" || x == "O"}
end

def current_player(board)
  x = board.count {|x| x == "X"}
  o = board.count {|o| o == "O"}
  return x > o ? "O" : "X"
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combos|
    board[win_combos[0]] == board[win_combos[1]] && board[win_combos[1]] == board[win_combos[2]] && position_taken?(board, win_combos[0])
  end
end

def full?(board)
  return board.all? { |x| x == "X" || x == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    x = board.count {|x| x == "X"}
    o = board.count {|o| o == "O"}
    return x > o ? "X" : "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
