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
  top_row = " #{board[0]} | #{board[1]} | #{board[2]} "
  mid_row = " #{board[3]} | #{board[4]} | #{board[5]} "
  bot_row = " #{board[6]} | #{board[7]} | #{board[8]} "
  dash = "-----------"
  
  puts "#{top_row}\n#{dash}\n#{mid_row}\n#{dash}\n#{bot_row}"
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, idx, token)
  board[idx] = token
end

def position_taken?(board, pos)
  return false if board[pos] == " "
  true
end

def valid_move?(board, pos)
  return false if position_taken?(board, pos)
  return true if pos.between?(0, 8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  idx = input_to_index(input)
  if valid_move?(board, idx)
    move(board, idx, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each { |space| count += 1 if space == "X" || space == "O"}
  count
end

def current_player(board)
  return "X" if turn_count(board).even?
  return "O" if turn_count(board).odd?
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    win_idx_1 = win_combo[0]
    win_idx_2 = win_combo[1]
    win_idx_3 = win_combo[2]
    
    pos_1 = board[win_idx_1]
    pos_2 = board[win_idx_2]
    pos_3 = board[win_idx_3]
    
    if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
      return win_combo
    elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
      return win_combo
    end
  end
  false
end

def full?(board)
  board.all? {|cell| cell == "X" || cell == "O"}
end

def draw?(board)
  return true if !won?(board) && full?(board)
end

def over?(board)
  return true if won?(board) || draw?(board)
end

def winner(board)
  return nil if !won?(board)
  win = won?(board)
  return board[win[0]]
end

def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end