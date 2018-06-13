# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Second column
  [2,5,8], # Third column
  [0,4,8], # Diagonal left to right
  [2,4,6], # Diagonal right to left
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


def move(board, index, player_character)
  board[index] = player_character
  return board
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0, 8)
    return true
  else
    return false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  counter = 0
  
  board.each do |turn|
    if turn == "X" or turn == "O"
      counter += 1
    end
  end
  return counter
end


def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|


# grab each index from the win_combination that composes a win.
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]


# load the value of the board  
    position_1 = board[win_index_1] # Board[0]
    position_2 = board[win_index_2] # Board[1]
    position_3 = board[win_index_3] # Board[2]


# if conditions are met then return win_combination indexes that won.
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
   return win_combination
  else
    false
  end
  end
return false
end


def full?(board)
  board.all? { |index| index == "X" || index == "O"}
end


def draw?(board)
  full?(board) && !won?(board)
end


def over?(board)
  if
    (won?(board) != false) ||
    (full?(board) == true) ||
    (draw?(board) == true)
  return true
else
  return false
end
end


def winner(board)
  if won?(board) != false
    return board[won?(board).last]
  end
end


def play(board)
  while !over?(board)
    turn(board)
  end
  
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end