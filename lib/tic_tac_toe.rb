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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def valid_move?(board, index)
  if index.between?(1,9)
     if !position_taken?(board, index)
      true
    end
  end
   index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  board[index] != " "
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else valid_move?(board, index)
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |token|
    if token != " "
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board).odd?
    "O"
  else
    "X"
  end
end

def won?(board)
  f = TRUE
  WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  if position_1 == position_2 && position_1 == position_3 && position_1 != " "
    return win_combination
  else
    f = FALSE
  end
end
f
end

def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    TRUE
  else
    FALSE
  end
end

def over?(board)
  if won?(board) || draw?(board)
    TRUE
  else
    FALSE
  end
end

def winner(board)
  if won?(board)
  token = won?(board)
  win = board[token[0]]
  win
end
end

def play(board)
  if over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else if draw?(board)
      puts "Cat's Game!"
    end
  end
  else
    turn(board)
    play(board)
  end
end 