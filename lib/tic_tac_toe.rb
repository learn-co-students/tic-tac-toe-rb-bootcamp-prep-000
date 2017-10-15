WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
  [0, 4, 8], # Diagonal \
  [2, 4, 6], # Diagonal /
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)
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
  turns_played = 0
  board.each { |position|
    if position == "X" || position == "O"
      turns_played += 1
    end
  }
  turns_played
end

def current_player(board)
  (turn_count(board) % 2 == 0) ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index1 = win_combination[0]
    win_index2 = win_combination[1]
    win_index3 = win_combination[2]
    pos_1 = board[win_index1]
    pos_2 = board[win_index2]
    pos_3 = board[win_index3]
    if pos_1 == pos_2 && pos_2 == pos_3 && position_taken?(board, win_index1)
      return win_combination
    end
  end
  false
end

def full?(board)
  board.all? { |position| position != nil && position != " " }
end

def draw?(board)
  full?(board) && !won?(board) ? true : false
end

def over?(board)
  full?(board) || won?(board) || draw?(board) ? true : false
end

def winner(board)
  if win_combination = won?(board)
    board[win_combination[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
