# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
def won?(board)
  WIN_COMBINATIONS.detect do |set|
    board[set[0]] == board[set[1]] &&
    board[set[1]] == board[set[2]] &&
    position_taken?(board,set[0])
  end
end

def full?(board)
  board.all? {|value| value == "X" || value == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(board)
  count = 0
  board.each do |location|
    if location != " "
      count+=1
    end
  end
  return count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X": "O"
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
  display_board(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts ("Congratulations #{winner(board)}!")
  elsif draw?(board)
    puts ("Cat's Game!")
  end
end
