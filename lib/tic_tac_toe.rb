WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def play(board)
  board = [' ',' ',' ',' ',' ',' ',' ',' ',' ']
  while !over?(board)
    turn(board);
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(num)
  num = num.to_i;
  num = num - 1;
end

def move(array, index, token)
  array[index]=token;
end

def valid_move?(board, index)
  ((index >= 0) && (index < 9)) && !(position_taken?(board, index));
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  input = gets.strip;
  index = input_to_index(input);
  if (valid_move?(board, index))
    move(board, index, current_player(board));
    display_board(board);
  else
    turn(board);
  end
  draw?(board)
  won?(board)
end

def turn_count(board)
  board.count{|char| char == 'X' || char == 'O'}
end

def current_player(board)
  x = board.count('X');
  o = board.count('O');
  o < x ? 'O' : 'X'
end

def won?(board)
  WIN_COMBINATIONS.detect do |d|
    board[d[0]]==board[d[1]]&&
    board[d[1]]==board[d[2]]&&
    position_taken?(board, d[0])
  end
end

def full?(board)
  board.count(' ') == 0
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end
