
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  return index.to_i - 1
end

def move(board, index, player_token)
  board[index] = player_token
  return board
end

def position_taken?(board, index)
  if board[index] == ' ' || board[index] == '' || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
  if !position_taken?(board, index)  && index.between?(0, 8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"

  input = gets.strip

  until valid_move?(board, input_to_index(input))
    puts "Please enter 1-9:"
    input = gets.strip
  end
index = input.to_i - 1


  move(board, index, current_player(board))

  display_board(board)

end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  return turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_array|
    win_x = win_array.select do |win_sequence|
      board[win_sequence] == "X"
    end
    win_o = win_array.select do |win_sequence|
      board[win_sequence] == "O"
    end
    if win_x.length == 3
      return win_x
    elsif win_o.length == 3
      return win_o
    end
  end
  state = true
  board.each do |position|
    if position != " "
      state = false
    end
  end
  if state == true
    return false
  end
end

def full?(board)
  board.none? do |position|
    position == " "
  end
end

def draw?(board)
  # if won?(board)
  #   return false
  # elsif full?(board) &&
  #   return true
  # else
  #   return false
  # end
  !won?(board) && full?(board)
end

def over?(board)
  #if won?(board)
  #  return true
  #elsif draw?(board)
  #  return true
  #else
  #  return false
  #end

  won?(board) || draw?(board)
end

def winner(board)
  if won?(board).class == Array
    state = won?(board)
  else
    state = [9]
  end
  if board[state[0]] == "X"
    return "X"
  elsif board[state[0]] == "O"
    return "O"
  else
    return nil
  end
end
#board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
def play(board)
  until over?(board)
    turn(board)

  end
  if won?(board)
    token = winner(board)
    puts "Congratulations #{token}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end
