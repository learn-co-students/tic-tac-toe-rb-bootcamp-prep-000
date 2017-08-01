

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [0, 4, 8],
  [2, 4, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  integer = input.to_i
  index = integer - 1
end

def move(array, move_index, char)
  array[move_index] = char
  return array
end

def position_taken?(board, index)
  if (board[index] == " " || board[index] == "" || board[index] ==nil)
    false
  else
    true
  end
end

def valid_move?(board, index)
  if (index.between?(0,8) && (!position_taken?(board, index)))
    true
  else
    false
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if (space == "X" || space == "O")
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won? (board)
  WIN_COMBINATIONS.each do |win_combo|
    if ((win_combo.all? {|pos| board[pos] == "X"}) ||
      (win_combo.all? {|pos| board[pos] == "O"}))
      return win_combo
    end
  end
  nil
end

def full? (board)
  board.all? { |pos| pos == "X" || pos == "O" }
end

def draw? (board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner (board)
  if over?(board)
    if won?(board).all?{|pos| board[pos] =="X"}
      return "X"
    elsif won?(board).all?{|pos| board[pos] == "O"}
      return "O"
    else
      return nil
    end
  end
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

def play(board)
  #move_count = 0
  until over?(board)
    #if !over?(board)
    turn(board)
    #end
    #move_count += 1
  end
  if won?(board)
    the_winner = winner(board)
    puts "Congratulations #{the_winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
