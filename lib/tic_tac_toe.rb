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

def move (array, index, char)
  array[index] = char
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
  false
  elsif board[index] ==  "X" || board[index] == "O"
    true
end
end


def valid_move? (board, index)
  if index < 0 || index > 8 || board[index] ==  "X" || board[index] == "O"
  false
else index.between?(0,8) && board[index] ==  "X" || board[index] == "O"
  true
end
end

def turn (board)
  puts "Please enter 1-9:"
input = gets.strip
index = input_to_index(input)
if valid_move?(board, index) == true
  move(board, index, current_player(board))
  display_board(board)
else
  turn(board)
end
end

def turn_count(board)
  counter = 0
board.each do |char|
  if char != " "
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
  WIN_COMBINATIONS.each do |win_index|
    position_1 = win_index[0].to_i
    position_2 = win_index[1].to_i
    position_3 = win_index[2].to_i
    if board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X"
      return win_index
    elsif board[position_1] == "O" && board[position_2] == "O" && board[position_3] == "O"
      return win_index
    else
      false
    end
  end
  false
end

def full?(board)
  return board.all? {|i| i != " "}
end

def draw?(board)
!won?(board) && full?(board)
end


def over?(board)
 won?(board) || full?(board) || draw?(board)
 end

def winner(board)
  if !won?(board)
    return nil
  else
    win_positions = won?(board)
    winner = win_positions[0]
    return board[winner]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
  puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
