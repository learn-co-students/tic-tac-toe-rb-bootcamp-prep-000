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

def turn_count(board)
  n_turns = 0
  board.each do |e|
    if(e == "X" || e == "O")
      n_turns += 1
    end
  end
  return n_turns
end

def current_player(board)
  current_player = turn_count(board).even?? "X" : "O"
  return current_player
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

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_0 = combo[0]
    win_index_1 = combo[1]
    win_index_2 = combo[2]
    win_position_0 = board[win_index_0]
    win_position_1 = board[win_index_1]
    win_position_2 = board[win_index_2]
    if ( (win_position_0 == "X" && win_position_1 == "X" && win_position_2 == "X") ||  (win_position_0 == "O" && win_position_1 == "O" && win_position_2 == "O") )
        return combo
    end
  end
  return false
end

def full?(board)
  board.all? {|symbol| symbol == "X" || symbol == "O"}
end

def draw?(board)
  if (!won?(board) && full?(board))
    return true
  end
  return false
end

def over?(board)
  if(won?(board) || draw?(board) || full?(board))
    return true
  end
  return false
end

def winner(board)
  win_combo = won?(board)
  if(win_combo == false)
    return nil
  elsif win_combo.all?{|i| board[i] == "X"}
    return "X"
  else
    return "O"
  end
#  won?(board) && board[won?(board)[0]]
end

def play(board)
  while(!over?(board))
    turn(board)
  end
  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
