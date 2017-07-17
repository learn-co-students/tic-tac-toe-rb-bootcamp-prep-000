WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #left diagonal
  [2,4,6]  #right diagonal
]

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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] == "X" || board[location] == "O"
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(array)
  count = 0
  array.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
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

def won?(board)
    WIN_COMBINATIONS.each do |combo|
      if combo.all? {|position| board[position] == "X"} || combo.all? {|position| board[position] == "O"}
        return combo
      end
    end
    return false
end


def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  full?(board) && won?(board) == false
end

def over?(board)
  draw?(board) || won?(board) != false
end

def winner(board)
  index = won?(board)
  if index
    board[index[0]]
  else
    nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
