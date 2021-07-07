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

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

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

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, player_index)
  board[player_index] != " " && board[player_index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  inputs = gets.strip
  inputs = input_to_index(inputs)
  if valid_move?(board, inputs)
    move(board, inputs, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(boards)
  count = 0
  boards.each do |board|
    if board == "X" || board == "O"
      count += 1
    end
  end
  count
end

def current_player(boards)
  num = turn_count(boards)
  num.even? ? "X" : "O"
end

def won?(board)
  empty_board = board.all? do |empty_board|
    empty_board == " "
  end

  WIN_COMBINATIONS.each do |win_combinations|
    win_index1 = win_combinations[0]
    win_index2 = win_combinations[1]
    win_index3 = win_combinations[2]

    position_1 = board[win_index1]
    position_2 = board[win_index2]
    position_3 = board[win_index3]

    if empty_board == true
      return false
    elsif position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combinations
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combinations
    else
      false
    end
  end

  if full?(board) == true
    return false
  end

end

def full?(board)
  board.all? do |full|
    full != " "
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) != nil || false
    o_var = 0
    x_var = 0
    won?(board).each do |winner|
      if board[winner] == "X"
        x_var += 1
      elsif board[winner] == "O"
        o_var += 1
      end
    end

    if o_var > x_var
      return "O"
    elsif x_var > o_var
      return "X"
    end
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    end
  else
    puts "Cat's Game!"
  end
end
