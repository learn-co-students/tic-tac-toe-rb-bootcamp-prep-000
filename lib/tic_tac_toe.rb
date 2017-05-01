WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # left columns
  [1,4,7], # middle columns
  [2,5,8], # right column
  [0,4,8], # diag top left to right
  [6,4,2] #diag top right to left
]

def display_board(board)
  line = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts line
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts line
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

def valid_move?(board, index)
  if position_taken?(board, index) || index > board.length || index < 0
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    play_char = current_player(board)
    move(board, index, play_char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  return "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all? do |position|
    (position == "X" || position == "O")
  end
end

def draw?(board)
  return (!(won?(board)) && full?(board))
end

def over?(board)
  return (draw?(board) || won?(board))
end

def winner(board)
  win_combo = won?(board)
  if win_combo == false
    return nil
  else
    winning_position1 = win_combo[0]
    return board[winning_position1]
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
