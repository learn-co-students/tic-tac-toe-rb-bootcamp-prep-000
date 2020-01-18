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

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && position_taken?(board, index) == false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == false
    puts "Sorry, that is not a legal move."
    turn(board)
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  (turn_count(board) % 2).even? ? "X" : "O"
end

def won?(board)
  #put all possible winning rows into a collection
  possible_wins = WIN_COMBINATIONS.select do |combo|
    combo.all? do |index|
      position_taken?(board, index)
    end
  end
  if possible_wins.empty?
    return false
  end
  #check if any combos are actually wins
  possible_wins.each do |pw|
    if (pw.all?{|i| board[i] == "X"} || pw.all?{|i| board[i] == "O"})
      return pw
    end
  end
  #return false if nothing has won
  return false
end

def full?(board)
  board.all? do |position|
    !(position == " ")
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  won?(board) || full?(board) || draw?(board) ? true : false
end

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    return board[winning_combo[0]]
  else
    return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end