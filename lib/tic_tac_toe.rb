
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

def move(board, index, marker)
  if valid_move?(board, index)
    board[index] = marker
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, marker = current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  number_of_turns = 0
  board.each do |count|
    if count == "X" || count == "O"
      number_of_turns += 1
    end
  end
    return number_of_turns
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row 0
  [3,4,5], # Middle row 1
  [6,7,8], # Bottom row 2
  [0,3,6], # Column 1 3
  [1,4,7], # Column 2 4
  [2,5,8], # Column 3 5
  [0,4,8], # Back diagonal 6
  [2,4,6]  # Forward diagonal 7
  ]

def won?(board)
  WIN_COMBINATIONS.detect do |value|
    board[value[0]] == board[value[1]] && board[value[1]] == board[value[2]] && position_taken?(board, value[0])
  end
end

def full?(board)
  if board.any?{|marker| marker == " "} 
    return false # board is not full if blank spaces is true
  else
    return true # board is full
  end
end

def draw?(board)
  if full?(board) && won?(board) == nil # full and no winner
    puts "Cat's Game!"
    return true
  else
    return false
  end
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if won?(board)
    puts "Congratulations #{board[won?(board)[0]]}!"
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  winner(board) || draw?(board)
end
