WIN_COMBINATIONS = [
  [0, 1, 2],
  [0, 4, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 4, 6],
  [2, 5, 8],
  [3, 4, 5],
  [6, 7, 8]
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won? (board)
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  end

  WIN_COMBINATIONS.each do |combo|
    player = board[combo[0]]

    position_2 = board[combo[1]]
    position_3 = board[combo[2]]

    if ((player == position_2) && (player == position_3) && (player != " "))
      return combo
    end
  end

  return false
end

def full? (board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over? (board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  elsif full?(board)
    return true
  else
    return false
  end
end

def winner (board)
  if won?(board)
    combo = won?(board)
    player = board[combo[0]]
    return player
  else
    return nil
  end
end

def display_board(board)
  separator = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts separator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts separator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
  board
end

def valid_move? (board, index) 
  if ((index.between?(0, 8)) && !(position_taken?(board, index)))
    return true
  else
    return false
  end
end

def turn(board)
  player = current_player(board)
  
  puts "Please enter 1-9:"
  display_board(board)
  index = input_to_index(gets.strip)
  
  if (valid_move?(board, index) == true)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def current_player (board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def turn_count (board)
  count = 0
  
  board.each do |position|
    if (position == "X" || position == "O")
      count += 1
    end
  end
  
  return count
end

def play(board)
  9.times do
    if !over?(board)
      turn(board)
    end
  end

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end
end