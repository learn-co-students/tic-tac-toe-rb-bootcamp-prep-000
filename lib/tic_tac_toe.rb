WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[0, 4, 8],
[6, 4, 2]
]

def display_board(board)

puts     " #{board[0]} | #{board[1]} | #{board[2]} "
puts     "-----------"
puts     " #{board[3]} | #{board[4]} | #{board[5]} "
puts     "-----------"
puts     " #{board[6]} | #{board[7]} | #{board[8]} "

end

def input_to_index(user_input)
  tttmove = user_input.to_i - 1
end

def move(board, input_to_index, character)
  board[input_to_index] = character
end

def position_taken?(board, index)
 (board[index] == " " || board[index] == "" || board[index] == nil) ? false : true
end

def valid_move?(board, index)
 (!position_taken?(board, index) && index.between?(0,8)) ? true : false
end

def turn(board)
puts "Please enter 1-9:"
user_input = gets.strip
index = input_to_index(user_input)
  if !valid_move?(board, index)
    turn(board)
  else
    puts "Please enter 1-9:"
  move(board, index, current_player(board))
  display_board(board)
 end
 end

 def turn_count(board)
 counter = 0
board.each do |turn|
    if turn != " "
      counter += 1
    end
  end
  return counter
end

def current_player(board)
 if turn_count(board).even? == true
  return "X"
 else
   return "O"
 end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? do |spaces|
  spaces == "X" || spaces == "O"
 end
end


def draw?(board)
if full?(board) && !won?(board)
  true
 end
end


def over?(board)
  if full?(board) || won?(board) || draw?(board)
    true
   end
  end

  def winner(board)
  if winning_combination = won?(board)
    board[winning_combination[0]]
  end
end

def play(board)
while !over?(board)
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cat's Game!"
end
end
