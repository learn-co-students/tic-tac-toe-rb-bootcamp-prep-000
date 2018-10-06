WIN_COMBINATIONS = [
  [ 0, 1, 2 ],
  [ 3, 4, 5 ],
  [ 6, 7, 8 ],
  [ 0, 4, 8 ],
  [ 2, 4, 6 ],
  [ 0, 3, 6 ],
  [ 1, 4, 7 ],
  [ 2, 5, 8 ]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return (input.to_i - 1)
end

def move(board, position, token)
  board[position] = token;
end

def position_taken?(board, index)
  return !(board[index] == nil || board[index] == " ");
end

def valid_move?(board, index)
  (!position_taken?(board, index) && index.between?(0, 8));
end

def current_player(board)
  return turn_count(board)%2 == 0 ? "X" : "O";
end

def turn_count(board)
  count_array = board.each_index.select do |index|
    position_taken?(board, index);
  end
  
  return count_array.length;
  
end

def turn(board)
  input = gets.strip;
  token = current_player(board);
  index = input_to_index(input);
  if (valid_move?(board, index))
    move(board, index, token)
  else
    puts ("Invalid Move. Enter 1-9 for empty spot.");
    input = gets.strip;
  end
end

def draw?(board)
  (full?(board) && !won?(board))
end

def full?(board)
  board.each_index.all? do |index|
    position_taken?(board, index);
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |index_lst|
    if (
      index_lst.all? do |index|
        board[index] == "X"
      end
      )
      return index_lst;
    elsif (
      index_lst.all? do |index|
        board[index] == "O"
      end
      )
      return index_lst;
    end
  end
  return false;
end

def over?(board)
  return (won?(board) || draw?(board));
end

def winner(board)
  if(won?(board))
    return board[won?(board)[0]]
  else
    return nil;
  end
end

def play(board)
  until over?(board)
    turn(board);
  end
  
  if (won?(board))
    puts "Congratulations #{winner(board)}!";
  else
    puts "Cat's Game!";
  end
end