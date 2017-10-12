WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [2, 5, 8],
  [1, 4, 7],
  [0, 3, 6]
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "---------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
  return index
end

def position_taken?(board, index)
  if (board[index] == "X" || board[index] == "O")
    return true
  else
    return false
  end
end

def valid_move?(board, user_input)
  if !position_taken?(board, user_input)
    if user_input.between?(0,8)
      return true
    else
      return false
    end
  end
end

def move(board, pos, player)
  if valid_move?(board, pos)
    board[pos] = "#{player}"
  end
end

def turn(board)
 puts "please pick a number 1-9:"
 user_input = gets.strip
 index = input_to_index(user_input)
 who_plays = current_player(board)
 if valid_move?(board, index)
   move(board, index, who_plays)
 else
   turn(board)
 end
end

def turn_count(board)
  counter = 0
  turn_counter = 0
  while counter < 9 do
    if (board[counter] == "X" || board[counter] == "O")
      turn_counter += 1
    end
    counter += 1
  end
  return turn_counter
end

def current_player(board)
  turn_counter = turn_count(board)
  if (turn_counter.even? || turn_counter == 0)
    player = "X"
  else
    player = "O"
  end
  return player
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if (board[win[0]] == board[win[1]]) &&
    (board[win[1]] == board[win[2]]) &&
    (position_taken?(board, win[0]))
      return true
    end
  end
  return false
end

def full?(board)
  counter = 0
  spot_taken = 0
  while counter < 9 do
    if (board[counter] == "X") || (board[counter] == "O")
      spot_taken += 1
    end
    counter += 1
  end
  if (spot_taken == 9) && (!won?(board))
    return true
  else
    return false
  end
end

def draw?(board)
  if won?(board) == false
    if full?(board)
      return true
    end
    if won?(board)
      return false
    end
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    WIN_COMBINATIONS.each do |win|
      if (board[win[0]] == board[win[1]]) &&
       (board[win[1]] == board[win[2]]) &&
       (position_taken?(board, win[0]))
        return board[win[0]]
      end
    end
  end
end

def play(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end
