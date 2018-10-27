def display_row(board, row_number)
  row_start = 3 * row_number
  row = [
    board[row_start],
    board[row_start + 1],
    board[row_start + 2]
  ]
  puts " #{row[0]} | #{row[1]} | #{row[2]} "
end

def display_board(board)
  separator = "-----------"
  
  display_row(board, 0)
  puts(separator)
  display_row(board, 1)
  puts(separator)
  display_row(board, 2)
end

def input_to_index(input)
  input.strip.to_i - 1
end

def move(board, index, character)
  board[index] = character
  return board
end

def valid_move?(board, index)
  return index.between?(0, 8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  contents = board[index]
  return (contents != " ") && (contents != "") && (contents != nil)
end


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

def won?(board)
  winning_positions = nil

  WIN_COMBINATIONS.each do |combination|
    c1 = combination[0]
    c2 = combination[1]
    c3 = combination[2]
    
    if(position_taken?(board, c1))
      b1 = board[c1]
      b2 = board[c2]
      b3 = board[c3]
    
      row_symbol = b1
      if row_symbol == b2 && row_symbol == b3
        winning_positions = combination        
      end
    end
  end
  
  return winning_positions
end

def full?(board)
  (0..8).all? do |index|
    position_taken?(board, index)
  end
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  winning_positions = won?(board)
  if(winning_positions)
    return board[winning_positions[0]]
  else
    return nil
  end
end


def turn_count(board)
  count = 0
  (0..8).each do |index|
    if(position_taken?(board, index))
      count += 1
    end
  end
  
  return count
end

def current_player(board)
  if(turn_count(board).even?)
    return "X"
  end
  return "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  
  index = input_to_index(input)
  
  if(valid_move?(board, index))
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    symbol = winner(board)
    puts "Congratulations #{symbol}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
