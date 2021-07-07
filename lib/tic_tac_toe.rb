require 'pry'

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

def move(board, index, player)
  #current_player = "X"
  board[index] = player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts 'Please enter 1-9:'

  user_input = gets.strip
  index = input_to_index(user_input)

   valid_move?(board, index ) ? move(board, index, current_player(board)) : turn(board)

   display_board(board)
end


def turn_count(board)
  ans = board.select { |ele| ele == 'X' || ele == 'O' }
  ans.count
end


def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end


# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == ' ')
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8], #Diagonal1
  [6, 4, 2]  #Diagonal2
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_1 = combo[0]
    win_2 = combo[1]
    win_3 = combo[2]

    position_1 = board[win_1]
    position_2 = board[win_2]
    position_3 = board[win_3]

    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_1)
      return combo
    end
  end
   false || nil
end

def full?(board)
 !board.any?{ |ele| ele == ' ' }
end


def draw?(board)
 if won?(board)
   false
 else
  full?(board)
 end
end


def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  res = won?(board)
  if res
    board[res[0]]
  else
    false || nil
  end
end



def play(board)
until over?(board)
  turn(board)
end
#binding.pry
if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cat's Game!"
end
end


