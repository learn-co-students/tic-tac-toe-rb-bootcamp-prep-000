# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if board[win_combo[0]] == 'X' && board[win_combo[1]] == 'X' && board[win_combo[2]] == 'X'
      return win_combo
    elsif board[win_combo[0]] == 'O' && board[win_combo[1]] == 'O' && board[win_combo[2]] == 'O'
      return win_combo
    end
  end
  return false
end

def full?(board)
  board.all? do |position|
    position == 'X' || position == 'O'
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
end

def winner(board)
  who_won = won?(board)
  if who_won
    return board[who_won[0]]
  else
    return nil
  end
end

def turn_count(board)
  counter = 0
  board.each do |index|
    if index == 'X' || index == 'O'
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    'X'
  else
    'O'
  end
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

def move(board, index, current_player)
  board[index] = current_player
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

def play(board)
  while !over?(board)
    turn(board)
  end

  if winner(board) == 'X'
    puts "Congratulations X!"
  elsif winner(board) == 'O'
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end
end
