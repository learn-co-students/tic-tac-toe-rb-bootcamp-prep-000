WIN_COMBINATIONS = 
[
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

def input_to_index(input)
  index = (input.to_i)-1
end

def move(board, index, character)
  board[index]=character
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    true
  elsif board[index] == " " || board[index] == "" || board[index] == nil
    false 
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if 
    valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else 
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |board_position|
    if board_position == "X" || board_position == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
  if
      board[win_combination[0]] == "X" &&
      board[win_combination[1]] == "X" &&
      board[win_combination[2]] == "X"
    won = win_combination
  elsif
      board[win_combination[0]] == "O" &&
      board[win_combination[1]] == "O"  &&
      board[win_combination[2]] == "O"
    won = win_combination
  else
    won = false
  end
won 
end
end

def full?(board)  
board.none?{|i| i == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    true
  end
end

def winner(board)
 if won?(board)
   winner = won?(board)[0]
   board[winner]
 end
end

def play(board)
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
  while !over?(board)
  turn(board)
  play(board)
end
end