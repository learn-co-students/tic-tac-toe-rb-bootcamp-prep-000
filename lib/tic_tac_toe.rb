WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [6,4,2],
  [0,4,8],
  [1,4,7],
  [0,3,6],
  [2,5,8]
]

def won?(board)
winner = false
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

     position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

     # empty_board = (position_1 == " " && position_2 == " " && position_3 == " ")
    winning_move = (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
    # draw = (position_1 == "X" && position_2 == "O" && position_3 == "X") || (position_1 == "O" && position_2 == "X" && position_3 == "O")

     if winning_move
      winner = true
      return win_combination # return the win_combination indexes that won.
    else
      winner = false
     end
  end
winner
end

def full?(board)
  if board.include?(" ")
    false
  else
    true
  end
end

def draw?(board)
  full?(board) && !won?(board)
end


def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    end
  end
  counter
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

def move(board, input_to_index, players_character)
  board[input_to_index] = players_character
  return board
end

def valid_move?(board,index)
  if (!position_taken?(board, index)) && (index.between?(0,8))
    true
  else
    false
  end
end

def position_taken?(board, index)
   if (board[index] ==  " " || board[index] == "" || board[index] == nil)
     false
   else
     true
   end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
    if valid_move?(board, index) == true
      move(board, index, players_character = "X")
    else
      turn(board)
    end
  display_board(board)
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board) == true
    puts "Congratulations #{winner(board)} !"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
