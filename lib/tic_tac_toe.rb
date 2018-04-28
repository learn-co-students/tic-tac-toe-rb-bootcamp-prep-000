WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8],
                    [0,3,6], [1,4,7], [2,5,8],
                    [0,4,8], [2,4,6]]

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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0 
  board.each do |space|
    if !(space.nil? || space == " ")
      count += 1
    end
  end
  return count
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    pos_0 = combination[0]
    pos_1 = combination[1]
    pos_2 = combination[2]
    if (board[pos_0] == "X" && board[pos_1] == "X" && board[pos_2] == "X") ||
      (board[pos_0] == "O" && board[pos_1] == "O" && board[pos_2] == "O")
      return combination
    end
  end
  return false
end

def full?(board)
  board.none?{|space| space.nil? || space == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win_combo = won?(board)
  if (win_combo)
    return board[win_combo[0]]
  end
  return nil;
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






