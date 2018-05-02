WIN_COMBINATIONS = [[0, 1, 2],
                    [3, 4, 5],
                    [6, 7, 8],
                    [0, 3, 6],
                    [1, 4, 7],
                    [2, 5, 8],
                    [0, 4, 8],
                    [2, 4, 6]]

# START SECONDARY HELPERS
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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def full?(board)
  value = true
  board.each do |space|
    value = value && space != " "
  end
  value
end
# END SECONDARY HELPERS


def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    position_taken?(board, combo[0]) && position_taken?(board, combo[1]) &&
    position_taken?(board, combo[2]) && ((board[combo[0]] == "X" &&
    board[combo[1]] == "X" && board[combo[2]] == "X") || (board[combo[0]] == "O" &&
    board[combo[1]] == "O" && board[combo[2]] == "O"))
  end
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  won?(board) || draw?(board) || full?(board) ? true : false
end

def winner(board)
  won = won?(board)
  won ? board[won[0]] : nil
end

def turn_count(board)
  counter = 0

  board.each do |spot|
    if spot == "X" || spot == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  player = ( turn_count(board) % 2 == 0 ) ? "X" : "O"
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

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
