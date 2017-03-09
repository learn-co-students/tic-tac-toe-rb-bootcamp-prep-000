WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1 >= 0 ? (return user_input.to_i - 1 ): (return -1)
end

def move(board, position, player)
  board[position.to_i] = player
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    true
  elsif board[index] == " " || board[index] == ""
    false
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0,8)
    true
  elsif position_taken?(board, index)
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  pos = input_to_index(input)
  player = "X"
  if valid_move?(board,pos)
    turn_count(board) % 2 == 0 ? player = "X" : player = "O"
    move(board,pos,player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  for item in board
    item == "X" || item == "O" ? (count+=1): (count -0)
  end
  return count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? (return "X") : (return "O")
end

def won?(board)
  if board == [" "," "," "," "," "," "," "," "," "]
      return false
  else
    for win_combo in WIN_COMBINATIONS
    #puts win_combo[0] == board.index(board[win_combo[0]])
      win_index_1 = win_combo[0]
      win_index_2 = win_combo[1]
      win_index_3 = win_combo[2]

      pos_1 = board[win_index_1]
      pos_2 = board[win_index_2]
      pos_3 = board[win_index_3]

      if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
        return win_combo
      elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
        return win_combo
      end
    end
    return false
  end
end

def full?(board)
  board.none?{|i| i == " "}
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  won?(board) || draw?(board) || full?(board) ? true : false
end

def winner(board)
  if over?(board) && board[won?(board)[0]] == "X" && board[won?(board)[1]] == "X" && board[won?(board)[2]] == "X"
    return "X"
  elsif over?(board) && board[won?(board)[0]] == "O" && board[won?(board)[1]] == "O" && board[won?(board)[2]] == "O"
    return "O"
  else
    return nil
  end
end

def play(board)
  until over?(board)
    if won?(board)
      return "Congratulations #{winner(board)}!"
    elsif draw?(board)
      return "Cats Game!"
    else
      turn(board)
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

play(["X", "O", "X", "O", "X", "X", "O", "X", "O"])
