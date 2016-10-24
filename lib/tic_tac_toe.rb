WIN_COMBINATIONS = [
#rows
  [0,1,2],
  [3,4,5],
  [6,7,8],
#columns
  [0,3,6],
  [1,4,7],
  [2,5,8],
#diagonals
  [0,4,8],
  [2,4,6]
]

def play(board)
  while over?(board) == false
    turn(board)
  end
  if winner(board)
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def over?(board)
  return true if won?(board) || draw?(board) || full?(board)
  false
end

def turn(board)
  valid_input = false
  while !valid_input
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    if (valid_move?(board,index))
      move(board, index, current_player(board))
      display_board(board)
      valid_input = true
    else
      puts "Invalid input"
    end
  end
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def valid_move?(board, index)
  if (index >= 0) && (index <= 8)
    return !position_taken?(board,index)
  end
  false
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def move(board, index, player)
  board[index] = player
  board
end

def turn_count(board)
  remaining_turns = board.count(" ");
  9 - remaining_turns
end

def current_player(board)
  (turn_count(board) % 2) == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if (position_taken?(board, combo[0])) && (board[combo[0]]==board[combo[1]]) && (board[combo[1]]==board[combo[2]])
      return combo
    end
  end
  false
end

def full?(board)
  return false if (board.index(" "))
  true
end

def draw?(board)
  game_won = won?(board)
  board_full = full?(board)
  return true  if board_full  && !game_won
  return false if !board_full && !game_won
  return false if game_won
#  return true  if full?(board)  && !won?(board)
#  return false if !full?(board) && !won?(board)
#  return false if won?(board)
end

def winner(board)
  combo = won?(board)
  board[combo[0]] if combo
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
