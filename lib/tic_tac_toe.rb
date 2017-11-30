# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left colunm
  [1,4,7], # middle colunm
  [2,5,8], # right colunm
  [0,4,8], # main diagonal
  [2,4,6] # inverse diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[5]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
  return board
end

def position_taken?(board, index)
  board[index] == "O" || board[index] == "X"
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, input)
    move(board, input, player)
    display_board(board)
  else
    puts "Not a valid move."
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    x_win = win_combo.all? do |index|
      board[index] == "X"
    end
    o_win = win_combo.all? do |index|
      board[index] == "O"
    end
    if x_win || o_win
      return win_combo
    end
  end
  false
end

def turn_count(board)
  count = 0
  board.each do |ind|
    if ind != " " && ind != "" && ind != nil
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def full?(board)
  board.none?{|index| index == " " || index == "" || index == nil} 
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if !won?(board)
    return nil
  end
  board[won?(board)[0]]
end

def play(board)
  until over?(board) do
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
