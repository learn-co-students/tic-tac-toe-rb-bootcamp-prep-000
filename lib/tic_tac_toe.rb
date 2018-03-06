require "pry"
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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def full?(board)  board.all? do |position|
    position == "X" || position == "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]] && position_taken?(board, win_combo[1])
  end
end

def over?(board)
  full?(board) || won?(board)
end

def draw?(board)
  full?(board) && !won?(board)
  # won?(board) == nil && full?(board) == true
  # if !won?(board) && full?(board)
  #   return true
  # else
  #   return false
  # end
end

def winner(board)
  if won?(board).kind_of?(Array)
    board[won?(board)[0]]
  end
end


def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
    board[index] = current_player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1
    end
  end
  counter
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    #puts "That is not a valid entry!"
    # binding.pry
    turn(board)
  end
end

# def input
#   index = input_to_index(gets.strip)
# end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Define your play method below
def play(board)
  # until over?(board)
  while !over?(board) && !draw?(board)
    turn(board)

  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

# def check(board)
#     # if draw?(board)
#     #   puts "Cat's Game!"
#     # elsif won?(board)
#     #   puts "Congratulations #{winner(board)}!"
#     # end
#     if won?(board)
#       puts "Congratulations #{winner(board)}!"
#     elsif draw?(board)
#       puts "Cat's Game!"
#     end
# end
