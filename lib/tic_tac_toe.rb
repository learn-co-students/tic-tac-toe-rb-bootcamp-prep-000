# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def won?(board)
  WIN_COMBINATIONS.each do |i|
    if i.all?{|index| board[index] == "X"}
      return i
    elsif i.all?{|index| board[index] == "O"}
      return i
    end
  end
  return false
end

def full?(board)
  return board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  return won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    player = won?(board)
    return board[player[0]]
  else return nil
  end
end

def turn_count(board)
  count = 0
  board.each do | element |
    if element == "X" || element == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  player_one = "X"
  player_two = "O"
  if turn_count(board) % 2 == 0
    return player_one
  else
    return player_two
  end
end

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

def move(board, index, cp)
  board[index] = cp
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    cp = current_player(board)
    move(board, index, cp)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
