def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    winning_player = winner(board)
    puts "#{winning_player} wins!"
  else
    puts "Cat's Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  position = input_to_index(input)
  
  if valid_move?(board, position)
    player_token = current_player(board)
    move(board, position, player_token)
    display_board(board)
  else
    puts "Invalid Move"
    turn(board)
  end
end

def input_to_index(input)
 input.to_i - 1
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  space = board[index]
  space != " " && space != "" && space != nil
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " "
      counter += 1
    else 
    end
  end
  counter
end

def move(board, position, player_token)
  board[position] = player_token
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    position_1 == "X" && position_2 == "X" && position_3 == "X" ||
    position_1 == "O" && position_2 == "O" && position_3 == "O"
  end
end

def full?(board)
  board.none? do |character|
    character == " "
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board) == nil
    nil
  else
    winning_combo = won?(board)
    first_winning_space = winning_combo[0]
    board[first_winning_space]
  end
end

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
