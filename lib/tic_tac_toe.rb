# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  user_index = input_to_index(user_input)
  current_player = current_player(board)
  if valid_move?(board, user_index)
    move(board, user_index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def current_player(board)
  size_check = board.select { |token| token == "X" || token == "O" }
  if size_check.length % 2 == 0
    current_player = "X"
  else current_player = "O"
  end
end

def turn_count(board)
  count_check = board.select{ |token| token == "X" || token == "O" }
  turns = count_check.length
end

# Define your WIN_COMBINATIONS constant
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
  WIN_COMBINATIONS.detect do |combination|
    combination.all? do |position|
      board[position] == "X"
    end ||
    combination.all? do |position|
      board[position] == "O"
    end
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    winner = board[won?(board)[0]]
  else won?(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
