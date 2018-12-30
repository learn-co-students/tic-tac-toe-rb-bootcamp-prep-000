WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #mid row
  [6, 7, 8], #bottom row
  [0, 3, 6], #column 1
  [1, 4, 7], #column 2
  [2, 5, 8], #column 3
  [0, 4, 8], #diag start L
  [2, 4, 6] #diag start R
]

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

def move(board, index, char)
  board[index] = char
  return board
end

=begin 
my code...
def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  elsif board[index] == " " || board[index] == "" || board[index] = nil 
    return false
  end
end
=end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0, 8) == false
    return false
  elsif index.between?(0, 8) == true && position_taken?(board, index) == false 
    return true
  else 
    return false
  end
end

def turn_count(board)
  counter = 0
  board.each do |char|
    if char == "X" || char == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index) == true 
    char = current_player(board)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_one = win_combination[0]
    win_index_two = win_combination[1]
    win_index_three = win_combination[2]
  
    position_one = board[win_index_one]
    position_two = board[win_index_two]
    position_three = board[win_index_three]
    if position_one == "X" && position_two == "X" && position_three == "X" || position_one == "O" && position_two == "O" && position_three == "O"
      return win_combination
    end 
  end
  else 
    return false
end

#position taker helper method?
def full?(board)
  board.all? do |char|
    char == "X" || char == "O"
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  end
end

def over?(board)
  if draw?(board) == true || won?(board) != false 
    return true
  end
end

def winner(board)
  won = won?(board) #won = WIN-COM[won[1, 2, 3]
  if won != false
    return board[won[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end