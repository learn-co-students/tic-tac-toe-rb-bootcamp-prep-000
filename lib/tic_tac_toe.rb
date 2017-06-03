WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    bd0 = combo[0]
    bd1 = combo[1]
    bd2 = combo[2]

    if board[bd0] == "X" && board[bd1] == "X" && board[bd2] == "X"
      return combo
    elsif board[bd0] == "O" && board[bd1] == "O" && board[bd2] == "O"
      return combo
    end
  end
  return false
end

def full?(board)
  board.all? { |e| e == "X" || e == "O" }
end

def over?(board)
  won?(board) || full?(board)
end

def draw?(board)
  !won?(board) && full?(board)
end

def winner(board)
  if won?(board)
    x = won?(board)
    y = board[x[0]]
    return y
  end
  return nil
end

def turn_count(board)
  count = 0
  board.each do |mark|
    if mark == "X" || mark == "O"
      count += 1
    end
  end
  count
end

def current_player(board)

  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
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

def move(board, index, current_player)
  board[index] = current_player
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
    puts "please input a valid move"
    turn(board)
  end
end

# Define your play method below
def play(board)
while !over?(board) || draw?(board)
  turn(board)
  if draw?(board)
    puts "Cats Game!"
    return
  end
end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  end
end
