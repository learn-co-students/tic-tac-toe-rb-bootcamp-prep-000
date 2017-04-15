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

def turn_count(board)
  turns_played = 0
  board.each do |e|
    if e == "X" || e == "O"
      turns_played += 1
    end
  end
  turns_played
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Define your play method below
def play(board)
  while !over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom row
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
  [0, 4, 8], # Left to right diagonal
  [2, 4, 6], # Right to left diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |e|
    index1 = e[0]
    index2 = e[1]
    index3 = e[2]

    position1 = board[index1]
    position2 = board[index2]
    position3 = board[index3]

    if position1 == "X" && position2 == "X" && position3 == "X"
      return e
    end

    if position1 == "O" && position2 == "O" && position3 == "O"
      return e
    end
  end

  return false

end

def full?(board)
  board.all? { |e| e == "X" || e == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  end
  winner_index = won?(board)[0]
  board[winner_index]
end


