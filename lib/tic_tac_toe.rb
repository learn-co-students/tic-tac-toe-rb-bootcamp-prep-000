# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2], # Top row
                    [3, 4, 5], # Bottom row
                    [6, 7, 8], # Last row
                    [0, 3, 6], # Left col
                    [1, 4, 7], # Middle col
                    [2, 5, 8], # Right
                    [0, 4, 8], # X1
                    [2, 4, 6]  # X2
                    ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  index.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) and !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9"
  user_input = input_to_index(gets.strip)
  
  if valid_move?(board, user_input)
    move(board, user_input, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  9 - board.count(" ")
end

def current_player(board)
  (turn_count(board).even? ? "X" : "O")
end

def won?(board)
  # Check empty board
  if !board.any?{|c| c == "X" || c == "O"}
    return false
  end

  # Check for winners
  WIN_COMBINATIONS.select{|row| row.all?{|index| position_taken?(board, index)}}.each do |row|
    if row.all?{|index| board[index] == 'X'} or row.all?{|index| board[index] == 'O'}
      return row
    end
  end
  # No winners ? must be draw
  false
end

def full?(board)
  !board.any?(" ")
end

def draw?(board)
  # Draw
  if won?(board) or !full?(board)
    return false
  elsif board.count{|c| c == "O" or c == "X"} == 9
    return true
  end
end

def over?(board)
  (draw?(board) or won?(board))
end

def winner(board)
  player = won?(board)
  if player
    return board[player[0]]
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
