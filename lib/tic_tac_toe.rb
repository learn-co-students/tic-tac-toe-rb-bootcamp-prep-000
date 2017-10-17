


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =
[
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], #Bottom row
#diagonals
  [0,4,8], #left diag
  [2,4,6], #right diag
# up and down
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  input.to_i - 1
end

def move(board, position, char)
  board[position] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
    if board[index]==nil || position_taken?(board,index) || index < 0
      return false
    end
    if !position_taken?(board,index)
       return true
    end
end

def turn(board)
  # ask for input
  puts "Player "+ current_player(board)
  puts "Please enter 1-9:"
  # get input
  input = gets.strip
  # convert input to index
  index = input_to_index(input)
    # puts index
  # ask for input again until you get a valid input
  until (valid_move?(board,index) && -1 < index && index<10)
    # ask for input
    puts "Please enter 1-9:"
    # get input
    input = gets.strip
    # convert input to index
    index = input_to_index(input)
  end
  # make the move for index
  move(board, index, current_player(board))
  # show the board
  display_board(board)
end

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"
end

def won?(board)
  stuff = WIN_COMBINATIONS.each do |win|
    # puts win
    won_X = win.all? do |index|
      board[index] == 'X'
    end
    # puts won_X
    won_O = win.all? do |index|
      board[index] == 'O'
    end
    # puts won_O
    if won_O || won_X
      # puts 'return'
      return win
      # break
    end
  end
  # puts 'none found'
  return false
end

def full?(board)
  board.count(" ") == 0
  # board.all? do |space|
  #   position_taken?(board, space)
  # end
end

def draw?(board)
  full?(board)&&!won?(board)
end

def over?(board)
  draw?(board) || won?(board)!=false
end

def winner(board)
  status = won?(board)
  if status != false
    return board[status[0]]
  end
end


def play(board)
  # asks for players input on a turn of the game
  # checks if the game is over after every turn
  # checks if the game is won after every turn
  # checks if the game is draw after every turn
  # stops playing if someone has won
  # congratulates the winner
  # stops playing in a draw
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  end
  if draw?(board)
    puts "Cat\'s Game!"
  end
end

##       TESTS

# => play test
# board = [" ", " ", " ",
#          " ", " ", " ",
#          " ", " ", " "]
#
# draw_board = ["X", "X", "O",
#               "O", "O", "X",
#               "X", "X", "O"]
#
# play(board)

# => valid_move? test
# board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
# #
# puts "position 0"
# puts valid_move?(board,0)
# # position = 0
# # expect(valid_move?(board, position)).to be_truthy
# puts "position 4"
# puts valid_move?(board,4)
# # position = 4
# # expect(valid_move?(board, position)).to be_falsey
# puts "position -1"
# puts valid_move?(board,-1)
# # position = -1
# # expect(valid_move?(board, position)).to be_falsey






###old play
# def play(board)
#   turn_number = 0
#   until turn_number == 9
#     turn(board)
#     turn_number+= 1
#   end
# end
