require 'pry'

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Mid row
  [6, 7, 8], #Bottom row
  [0, 3, 6], #Left column
  [1, 4, 7], #Mid column
  [2, 5, 8], #Right column
  [0, 4, 8], #L to R diagonal
  [2, 4, 6] #R to L diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} ";
  puts "-----------";
  puts " #{board[3]} | #{board[4]} | #{board[5]} ";
  puts "-----------";
  puts " #{board[6]} | #{board[7]} | #{board[8]} ";
end

def input_to_index(input)
  input.to_i - 1;
end

def move(board, index, player_token)
  board[index] = player_token;
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false;
  elsif board[index] == "X" || board[index] == "O"
    return true;
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    return true;
  else
    return false;
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "invalid"
    turn(board)
  end
end

def turn_count(board)
  play_counter = 0;
  board.each do |space|
    if space == "X" || space == "O"
      play_counter += 1
    end
  end
  return play_counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X";
  else
    return "O";
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0];
    win_index_2 = win_combination[1];
    win_index_3 = win_combination[2];
    position_1 = board[win_index_1];
    position_2 = board[win_index_2];
    position_3 = board[win_index_3];
    if position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination;
    elsif position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination;
    end
  end
  return false;
end

def full?(board)
  board.each do |board_space|
    if board_space == " " || board_space == nil
      return false;
    end
  end
  return true;
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true;
  else
    return false;
  end
end

def winner(board)
  win_result = won?(board)
  if win_result == false
    return nil;
  else
    player = win_result[0]
    return board[player]
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
