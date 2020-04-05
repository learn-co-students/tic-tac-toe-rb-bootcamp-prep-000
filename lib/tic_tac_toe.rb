WIN_COMBINATIONS = [
  # horizontal
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  # vertical
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  # diagonal
  [0, 4, 8],
  [2, 4, 6],
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

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index) 
  if board[index] == " "
    false
  else
    true
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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

def turn_count(board)
  count = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  # for each win_combination in WIN_COMBINATIONS 
  WIN_COMBINATIONS.each do |win_combination|
    # copypasta
    win_index_1 = win_combination[0] 
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination 
    end
  end
  return false # empty board
end

def full?(board)
  board.all? { |space| space != "" && space != " " }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board).first]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) # calls on won? and returns who won
    puts "Congratulations #{winner(board)}!"
  else # cause a draw is determined in over? note to self in the future: that was not a question
    puts "Cat's Game!"
  end
end

