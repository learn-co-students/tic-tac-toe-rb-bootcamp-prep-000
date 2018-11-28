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
  divider = ''
  11.times { divider += '-' }

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts divider
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts divider
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, pos, token)
  board[pos] = token
end

def position_taken?(board, pos)
  !(board[pos] == ' ')
end

def valid_move?(board, pos)
  pos.between?(0, 8) && !position_taken?(board, pos)
end

def turn(board)
  puts "Please enter 1-9:"
  i = input_to_index(gets.chomp)

  if valid_move?(board, i)
    move(board, i, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.select { |i| i != " " }.size
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? { |el| el == 'X' || el == 'O' }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  combo = won?(board)
  return board[combo[0]] if combo
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
