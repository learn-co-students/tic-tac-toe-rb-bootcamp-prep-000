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
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def input_to_index(input)
  input = input.to_i
  input = input - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, position)
  position.between?(0, 8) && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  if !valid_move?(board, input)
    turn(board)
  end
  character = current_player(board)
  move(board, input, character)
  display_board(board)
end

def turn_count(board)
  turn = 0
  board.each do |position|
    if position == "X" || position == "O"
      turn += 1
    end
  end
  turn
end

def current_player(board)
  player = turn_count(board)
  player % 2 == 0 ? "X" : "O"
end

def won?(board)
  ["X", "O"].each do |symbol|
    WIN_COMBINATIONS.each do |win_combination|
      all_equal = win_combination.all? do |position|
        board[position] == symbol
      end
      if all_equal
        return win_combination
      end
    end
  end
  return false
end

def full?(board)
  board.each_with_index do |position, index|
    if !position_taken?(board, index)
      return false
    end
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  end
  return false
end

def winner(board)
  return won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cats Game!"
  end
end
