WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [0,3,6],# Middle row
  [6,7,8],  # Bottom row
  [0,4,8],  # First column
  [1,4,7], # Second column
  [2,5,8], #Third column #Diagonal column
  [2,4,6], #Diagonal column
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
      turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter+=1
    end
  end
  counter
end

def current_player(board)
  whose_turn = "X"
  if turn_count(board).even? == TRUE
    whose_turn = "X"
  else
    whose_turn = "O"
  end
  whose_turn
end


def won?(board)

  WIN_COMBINATIONS.each do |combo|
    win_index1 = combo[0]
    win_index2 = combo[1]
    win_index3 = combo[2]

    position_1 = board[win_index1]
    position_2 = board[win_index2]
    position_3 = board[win_index3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return combo
    end
  end
  return false
end

def full?(board)
  if board.all? {|full| full == "X" || full == "O"}
    true
  else
    false
  end
end

def draw?(board)
  did_win = won?(board)
  is_full = full?(board)
  if did_win == false && is_full == true
     true
  elsif did_win == false && is_full == false
     false
  elsif did_win == true
     false
  end
end

def over?(board)
  if(won?(board) != false) || (full?(board) == true) || draw?(board) == true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  end
  WIN_COMBINATIONS.each do |combo|
    win_index1 = combo[0]
    win_index2 = combo[1]
    win_index3 = combo[2]

    position_1 = board[win_index1]
    position_2 = board[win_index2]
    position_3 = board[win_index3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return "X"
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return "O"

    end
  end

end

def play(board)
  while over?(board) == false do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
