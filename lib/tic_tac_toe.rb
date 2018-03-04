# Helper Methods
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

def move(board, index, token)
  board[index] = token
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
  count = 0
  board.each do |space|
    if space != " "
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

WIN_COMBINATIONS = [
  [0,1,2], #top row win
  [3,4,5], #middle row win
  [6,7,8], #bottom row win
  [0,3,6], #first column win
  [1,4,7], #second column win
  [2,5,8], #third column win
  [0,4,8], #diagonal win
  [2,4,6] #diagonal win
]

def won?(board)
  won = false
  WIN_COMBINATIONS.detect do |combo|
    if board[combo[0]] == " "
      won = false
    elsif board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
      won = combo
    end
  end
  won
end

def full?(board)
  board.none?{|space| space == " "}
end

def draw?(board)
  won?(board) == false && full?(board) ? true : false
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board) != false
    board[won?(board)[0]]
  end
end
