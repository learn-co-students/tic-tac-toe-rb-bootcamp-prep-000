def position_taken?(*args)
  case args.size
    when 1
      value = args[0];
      return !(value.nil? || value == " " || value == "");
    when 2
      board = args[0];
      index = args[1];
      value = board[index];
      return !(board[index].nil? || board[index] == " " || board[index] == "");
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} ";
  puts "-----------";
  puts " #{board[3]} | #{board[4]} | #{board[5]} ";
  puts "-----------";
  puts " #{board[6]} | #{board[7]} | #{board[8]} ";
end

def input_to_index(user_input)
  user_input.to_i - 1;
end

def move(board, index, current_player)
  board[index] = current_player;
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index);
end

def turn(board)
  puts "Please enter 1-9:";
  input = gets.strip;
  index = input_to_index(input);
  if valid_move?(board, index)
    player = current_player(board);
    move(board, index, player);
    display_board(board);
  else
    turn(board);
  end
end

def turn_count(board)
  return board.count {|x| position_taken?(x)};
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O";
end

def play(board)
  until over?(board) do
    turn(board);
  end
  
  if (won?(board))
    puts "Congratulations #{winner(board)}!";
  elsif (draw?(board))
    puts "Cat's Game!";
  end
  
  # puts "Would you like to play again Y/N?";
  # play_again = gets.strip.upcase;
  # if (play_again == "Y")
  #   board = get_new_board;
  #   display_board(board)
  #   play(board);
  # end
end

# def get_new_board
#   return [" ", " ", " ", " ", " ", " ", " ", " ", " "];
# end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
  ];
  
def won?(board)
  winning_combo = nil;
  WIN_COMBINATIONS.any? do |combo|
    spot_arr = [board[combo[0]], board[combo[1]], board[combo[2]]];
    if ((spot_arr.all? {|x| x == "X"}) || (spot_arr.all? {|x| x == "O"}))
      winning_combo = combo;
    end
  end
  return winning_combo;
end

def full?(board)
  return board.all? {|x| position_taken?(x)};
end

def draw?(board)
  return full?(board) && won?(board).nil?;
end

def over?(board)
  return won?(board) || draw?(board) || full?(board);
end

def winner(board)
  winning_combo = won?(board);
  return winning_combo.nil? ? nil : board[winning_combo[0]];
end