# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # mid row
  [6, 7, 8], # bot row
  [0, 3, 6], # left col
  [1, 4, 7], # mid col
  [2, 5, 8], # right col
  [0, 4, 8], # diag
  [2, 4, 6] # anti-diag
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    pos_1 = board[combo[0]]
    pos_2 = board[combo[1]]
    pos_3 = board[combo[2]]

    if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
      return combo
    elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
      return combo
    end
  end
  return false
end

def full?(board)
  board.all? { |space| !(space.nil? || space == " ")}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

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
  counter = 0
  board.each do |space|
    if space == "O" || space == "X"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end


# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    game_winner = winner(board)
    puts "Congratulations #{game_winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
