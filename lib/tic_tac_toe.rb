
WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row
  [0, 3, 6], #Left col
  [1, 4, 7], #Middle col
  [2, 5, 8], #Right col
  [0, 4, 8], #Left to Right diagonal
  [2, 4, 6] #Right to Left diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  num = index.to_i
  return num - 1;
end

def move(board, index, char)
  board[index] = char
  return board
end

def position_taken?(board, index)
  if board[index] == " "
    false
  elsif board[index] == ""
    false
  elsif board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  on_board = index.between?(0, 8)
  position_on = position_taken?(board, (index))

  if (on_board == true) && (position_on == false)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)

  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if (space == "O") || (space == "X")
      count += 1
    end
  end
  return count
end


def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    elsif win_combination == [2, 4, 6]
      return false
    end
    false
  end
end

def full?(board)
  counter = 0
  board.each do |item|
    if item == " "
      counter+=1
    end
  end
  if counter == 0
    return true
  else
    return false
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win = won?(board)
  if (win != false)
    return board[win[0]]
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
