
WIN_COMBINATIONS = [
  [0, 1, 2], # top row
  [3, 4, 5], # middle row
  [6, 7, 8], # bottom row
  [0, 3, 6], # left column
  [1, 4, 7], # middle column
  [2, 5, 8], # right column
  [0, 4, 8], # top-left to bottom-right diagonal
  [2, 4, 6] # top-right to bottom-left diagonal
]

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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0 # if even
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |outer_pos| # First true, returns. Otherwise, nil
    win = false
    if position_taken?(board,outer_pos[0]) # If the first pos has X or O
      first_char = board[outer_pos[0]]     # Save the first char
      win = outer_pos.all? do |inner_pos|  # Make sure rest of row has same char
        board[inner_pos] == first_char
      end
    end
    win #returns true or false to the WIN_COMBINATIONS.detect
  end
end

def full?(board)
  board.all? do |pos|
    pos == "X" || pos == "O"
  end
end

def draw?(board)
  if !won?(board)
    if full?(board)
      return true
    else
      return false
    end
  end
  return false
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  end
  return false
end

def winner(board)
  if !won?(board)
    return nil
  else
    board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
