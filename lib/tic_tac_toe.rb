def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def valid_move?(board, index)
  index.between?(0, 8) && !(position_taken?(board, index))
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)

  if (valid_move?(board, index))
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |marking|
    if marking == "X" || marking == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8],
]

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] &&
    board[win_combination[1]] == board[win_combination[2]] &&
    position_taken?(board,win_combination[0])
  end
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winning_combo = won?(board)

  if winning_combo
    board[winning_combo.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  winning_token = winner(board)

  if winning_token != nil
    puts "Congratulations #{winning_token}!"
  else
    puts "Cat's Game!"
  end
end
