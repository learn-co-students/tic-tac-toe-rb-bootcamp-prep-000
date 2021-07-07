WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input = input.to_i
  input - 1
end

def move(board,index,character)
  board[index] = character
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def turn_count(board)
  move_count = x_slots(board) + o_slots(board)
end

def x_slots(board)
  x_count = board.select{|board_space| board_space == "X"}.length
end

def o_slots(board)
  o_count = board.select{|board_space| board_space == "O"}.length
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def position_taken?(board,index)
  board[index] == "X" || board[index] == "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if(valid_move?(board,index))
    character = current_player(board)
    move(board,index,character)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    if board[index_0] == "X" && board[index_1] == "X" && board[index_2] == "X"
      return win_combo
    elsif board[index_0] == "O" && board[index_1] == "O" && board[index_2] == "O"
      return win_combo
    end
  end
  return false
end

def full?(board)
  turn_count(board) == 9
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if(won?(board))
    if(x_slots(board) > o_slots(board))
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until(over?(board))
    turn(board)
  end
  if(draw?(board))
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end