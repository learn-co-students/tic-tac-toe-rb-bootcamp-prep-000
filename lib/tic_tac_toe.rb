def display_board(board)
  puts " "
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts " "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count { |a| a == "X" || a ==  "O" }
end

def current_player(board)
  if turn_count(board) % 2 == 1
    return "O"
  else  
    return "X"
  end
end

WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # up-down diagonal
  [6,4,2]  # down-up diagonal
  ]

def play(board)
  while !over?(board)
    turn(board)
  end
  
  if winner(board) 
    puts "#{winner(board)} won the game!"
  elsif draw?(board)
    puts "Cat's Game!"
  end 

  replay?
end

def replay?
  puts "Play again [Y/n]? "
  choice = gets.strip
  if choice[0].upcase == "Y"
    board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    display_board(board)
    play(board)
  else
    exit
  end
end
  
def won?(board)
  WIN_COMBINATIONS.each do | win_combo |
    board_values = board.values_at(*win_combo)
    if board_values.all? { |a| a == "X" } || board_values.all? { |a| a == "O" }
      return win_combo
    end
  end
  false
end

def full?(board)
  true if board.all? { |a| a == "X" || a == "O" }
end

def draw?(board)
  true if full?(board) && !won?(board)
end

def over?(board)
  true if full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board) then
    return board[won?(board)[0]]
  end
end

