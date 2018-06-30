

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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    current_player = current_player(board)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |cell|
    if cell == "X" || cell == "O"
      counter += 1
    end
  end
  
  return counter
end

def current_player(board)
  play_count = turn_count(board)
  player_turn = play_count % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
    
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)

  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  win_index = won?(board)
  
  if won?(board)
    if board[win_index[0]] == "X"
      return "X"
    elsif board[win_index[0]] == "O"
      return "O"
    else
      return nil
    end
  end
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

