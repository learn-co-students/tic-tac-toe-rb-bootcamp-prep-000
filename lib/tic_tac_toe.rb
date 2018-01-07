def turn_count (board)
  counter = 0
  board.each do |el|
    if el == "X"
      counter += 1
    elsif el == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else return "O"
  end
end

def full?(board)
  !board.any? { |x| x == " " }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  elsif !full?(board) && !won?(board)
    return false
  end
end

def winner(board)
    return nil if !won?(board)
    arr = won?(board)
    x = arr[0].to_i
    if board[x] == "X"
      return "X"
    elsif board[x] == "O"
      return "O"
    else return nil
    end
end

def won?(board)
  killer = []
  WIN_COMBINATIONS.each do |set|
    if board.count{|n| n == "X"} < 3 && board.count{|n| n == "O"} < 3
      return false
      elsif (board[set[0]] == "X" && board[set[1]] == "X" && board[set[2]] == "X")
      return set
      elsif (board[set[0]] == "O" && board[set[1]] == "O" && board[set[2]] == "O")
      return set
    else killer << set
    end
  end
  return false if killer == WIN_COMBINATIONS
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
    turn(board)
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
