# create board

# get user input

# player choose position

# keep track of player's turn & how many turns have played

# at every turn check to see if there's a winner.

# if winner congratulate

# if tie inform them a tie

WIN_COMBINATIONS = [
  [0,1,2], # top row win
  [3,4,5], # middle row win
  [6,7,8], # bottom row win
  [0,3,6], # left column win
  [1,4,7], # middle column win
  [2,5,8], # right column win
  [0,4,8], # left diagnal win
  [2,4,6]  # right diagnol win
]

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

def move(array, index, token)
  array[index] = token
  return array
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && position_taken?(board, index) != true
    return true
  else
    return nil
  end
end

def turn(board, token="X")
  puts "Enter position 1 thru 9: "
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input)
    board[input] = token
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |space_on_board|
    if space_on_board == "X" ||
       space_on_board == "O" ||
       space_on_board == "x" ||
       space_on_board == "o"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|

    position_1 = combo[0]
    position_2 = combo[1]
    position_3 = combo[2]

    position_on_board_1 = board[position_1]
    position_on_board_2 = board[position_2]
    position_on_board_3 = board[position_3]

    if (position_on_board_1 == "X" && position_on_board_2 == "X" && position_on_board_3 == "X") || (position_on_board_1 == "O" && position_on_board_2 == "O" && position_on_board_3 == "O")
      return combo
    end
  end
  return false
end

def full?(board)
  board.all? do |spot_on_board|
    spot_on_board == "X" || spot_on_board == "O"
  end
end

def draw?(board)
  is_full = full?(board)
  is_won = won?(board)
  if is_full == true && is_won == false
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end


def winner(board)
  if winning_combo = won?(board)
    board[winning_combo[0]]
  end
end


def play(board)
  until over?(board) == true
    token = current_player(board)
    turn(board, token)
    display_board(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
