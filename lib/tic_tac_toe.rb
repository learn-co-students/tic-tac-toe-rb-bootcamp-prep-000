WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]
  
def winning_combos(board)
WIN_COMBINATIONS.select do |winning_combo|
    (board[winning_combo[0]] == "X" && board[winning_combo[1]] == "X" && board[winning_combo[2]] == "X") || (board[winning_combo[0]] == "O" && board[winning_combo[1]] == "O" && board[winning_combo[2]] == "O")
   end
end
  
  def display_board(board)
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index)
    false
  elsif !(index.between?(0, 8))
    false
  else 
    true
 end
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
  counter = 0
  board.each do |board|
    if board == "X" || board == "O"
      counter += 1
    end
 end
counter
end

def current_player(board)
  turn_count(board).even? ? "X":"O"
end

def won?(board)
  winning_combos(board).first
end

def full?(board)
  !board.any? do |board_position|
   board_position == " "
 end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  winning_combination = won?(board)
  if winning_combination == nil
     nil
     elsif board[winning_combination[0]] == "X"
     "X"
   else
     "O"
   end
end

def play(board)
  until over?(board)
  turn(board)
end
  letter = winner(board)
  if letter != nil
    puts "Congratulations #{letter}!"
  else
    puts "Cat's Game!"
  end
end
  

