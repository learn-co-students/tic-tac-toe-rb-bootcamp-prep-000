WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  puts "Please enter a number:"

   user_input.to_i - 1
end

def move(array, position, char)
  array[position] = char
end

def position_taken?(board, index)
  if((board[index] == "X") || (board[index] == "O"))
    true
  else
    false
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input.to_i
  new_input = input_to_index(input)
  if(valid_move?(board, new_input))
    move(board, new_input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if (position == "X" || position == "O")
      counter += 1
    end
  end
  counter
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    position_taken?(board, combo[0]) && board[combo[0]] == board[combo[1]] && board[combo[2]] == board[combo[1]]
  end
end

def current_player(board)
  turn_count(board) % 2 == 0 || turn_count(board) == 0 ? "X" : "O"
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"

  end
end

def draw?(board)
  if full?(board) && !(won?(board))
    return true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    false
  end
end

def winner(board)
  winning_char = won?(board)
  if !(won?(board))
    return nil
  elsif board[winning_char[0]] == "X"
    return "X"
  elsif board[winning_char[0]] == "O"
    return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end