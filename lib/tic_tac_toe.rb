WIN_COMBINATIONS = [[0,1,2], [3,4,5,], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def turn_count(board)
  turn = 0
  board.each do |square|
    if square == "X" || square == "O"
      turn += 1
    end
  end
  turn
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  "O"
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(idx)
  new_idx = idx.to_i - 1
  new_idx
end

def move(array, idx, move)
  array[idx] = move
end

def position_taken?(array, idx)
  if array[idx] == " " || array[idx] == "" || array[idx] == nil
    false
  else
    true
  end
end

def valid_move?(array, idx)
  if idx.between?(0, 8) && position_taken?(array, idx) == false
    true
  elsif idx.between?(0, 8) == false
    false
  elsif position_taken?(array, idx) == true
    false
  end
end

def turn(array)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(array, index) && (position_taken?(array, index) == false)
    move(array, index, current_player(array))
    display_board(array)
  else
    turn(array)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")
      return win_combination
    end
  end
  false
end

def full?(board)
  is_full = true
  board.each_index do |i|
    if !(position_taken?(board,i))
      is_full = false
    end
  end
  is_full
end

def draw?(board)
  if full?(board) && (won?(board)==false)
    return true
  end
  false
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  end
  false
end

def winner(board)
  if won?(board)
    combination = won?(board)
    winner = board[combination[0]]
  end
  winner
end

def play(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
