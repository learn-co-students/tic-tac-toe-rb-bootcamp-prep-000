WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  if user_input.to_i.to_s != user_input
    -1
  else
    user_input.to_i - 1
  end
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, position)
  (board[position] == "X" || board[position] == "O")?
  true : false
end

def valid_move?(board, position)
  if position_taken?(board, position) || position < 0 || position > 8
    false
  else
    true
  end
end

def turn(board)
  puts "input: "
  index = input_to_index(gets.strip)
  while !valid_move?(board, index)
    puts 'input: '
    index = input_to_index(gets.strip)
  end
  char = current_player(board)
  move(board, index, char)
end

def turn_count(board)
  count = 0
  board.each do |element|
    if element == 'X' || element == 'O'
      count += 1
    end
  end
  count
end

def current_player(board)
  (turn_count(board) % 2 == 0)?
  'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    if board[win[0]] == 'X' && board[win[1]] == 'X' && board[win[2]] == 'X'
      return true
    elsif board[win[0]] == 'O' && board[win[1]] == 'O' && board[win[2]] == 'O'
      return true
    end
  end
  false
end

def full?(board)
  if turn_count(board) == 9 && !won?(board)
    true
  elsif turn_count(board) < 9 && !won?(board)
    false
  end
end

def draw?(board)
  if full?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |win|
    if board[win[0]] == 'X' && board[win[1]] == 'X' && board[win[2]] == 'X'
      return "X"
    elsif board[win[0]] == 'O' && board[win[1]] == 'O' && board[win[2]] == 'O'
      return "O"
    end
  end
  return nil
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
