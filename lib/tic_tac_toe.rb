
def current_player(board)
  which_turn = turn_count(board)

  which_turn.even? ? "X" : "O"

end

def turn_count(board)

  counter = 0

  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end


  end
return counter

end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [2, 5, 8],
  [1, 4, 7],
  [0, 4, 8],
  [2, 4, 6]
]

def won?(board)

  WIN_COMBINATIONS.each do |combination|

    # set the places we are checking
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]

    # fetch values from board
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return [win_index_1, win_index_2, win_index_3]

    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return [win_index_1, win_index_2, win_index_3]

    end



  end

  # we now need to return FALSE if true was never returned during the "each" loop - this covers any situation with no win condition
  return false

end

def full?(board)

  # check all elements and return TRUE only if all spaces are occupied
  board.all? do |space|
    space == "X" || space == "O"
  end

end

def draw?(board)

  if won?(board)
    false
  elsif !full?(board)
    false
  elsif full?(board)
    true

  end

end


def over?(board)

  if won?(board)
    true
  elsif draw?(board)
    true
  else
    false
  end

end

def winner(board)

  win_positions = won?(board)

  if won?(board)

    if board[win_positions[0]] == "X"
      return "X"
    elsif board[win_positions[0]] == "O"
      return "O"
    end

      # return nil if won? does not evaluate to true - no winner
      return nil
  end
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
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end

end

    # Define your play method below
def play(board)


  until over?(board)
    turn(board)
    won?(board)
    draw?(board)
  end

  if won?(board)
    game_winner = winner(board)
    puts "Congratulations #{game_winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
