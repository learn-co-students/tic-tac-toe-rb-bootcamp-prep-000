WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
  board[combination[0]] == board[combination[1]] &&
  board[combination[1]] == board[combination[2]] &&
  position_taken?(board, combination[0])
  end
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
    (index >= 0 && index < 9) && !position_taken?(board, index)
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def input_to_index(input)
    index = input.to_i - 1
end

def move(board, index, token)

  board[index] = token
end



def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  return "O"
end

def turn(board)
  display_board(board)
  token = current_player(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    move(board, index, token)
  else
    while !valid_move?(board, index)
      display_board(board)
      puts "Please enter 1-9:"
      index = input_to_index(gets.strip)
    end
    move(board, index, token)
  end
end




def full?(board)
  board.all? do |token|
    token == "X" || token == "O"
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  elsif  won?(board)
    return false
  end
end

def over?(board)

  won?(board) || draw?(board)
end

def play(board)

  until over?(board)
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

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    board[winning_combo[0]]
  end
end
