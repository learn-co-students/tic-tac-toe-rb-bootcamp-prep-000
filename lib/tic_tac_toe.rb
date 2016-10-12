WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
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

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |block|
    if block == "X" || block == "O"
        turns += 1
    end
  end
  return turns
end

def current_player(board)
  if turn_count(board) % 2 == 0 || turn_count(board) == 0
    return "X"
  elsif turn_count(board) % 2 == 1
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index_1 = combo[0]
    win_index_2 = combo[1]
    win_index_3 = combo[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3
    if position_1 == position_2 && position_1 == position_3 && position_taken?(board, win_index_1)
      return combo
    end
  end
  return false
end

def full?(board)
  board.none?{|position| position == " " || position.nil?}
end

def draw?(board)
   !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  else
    if board[won?(board)[0]] == "X"
      return "X"
    elsif board[won?(board)[0]] == "O"
      return "O"
    end
  end
end

def play(board)
  turn = 0
  while turn < 9 do
    if !over?(board)
      turn(board)
      turn += 1
    else
      winner = winner(board)
      puts "Congratulations #{winner}!" if won?(board)
      puts "Cats Game!" if draw?(board)
      break
    end
  end
end
