WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #Bottom row
  [0, 3, 6], #Left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #diagonal 1
  [2, 4, 6] #diagonal 2
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  position = user_input.to_i - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end

def valid_move?(board, position)
  position.between?(0, 8) && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter 1-9"
  user_input = gets.strip
  position = input_to_index(user_input)
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = []
  board.select do |xo|
    turns << xo if xo != " "
  end
  turns.size
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |winning_combo|
    win_index = winning_combo
      (board[win_index[0]] == "X" && board[win_index[1]] == "X" && board[win_index[2]] == "X") ||
      (board[win_index[0]] == "O" && board[win_index[1]] == "O" && board[win_index[2]] == "O")
  end
end

def full?(board)
  if board.detect{|check| check == " "}
    false
  else
    true
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    return board[winning_combo[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else draw?(board)
      puts "Cat's Game!"
    end
end
