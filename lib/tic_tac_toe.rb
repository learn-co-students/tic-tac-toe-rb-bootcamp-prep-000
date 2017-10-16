def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
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

def valid_move?(board, index)
  if index.between?(0,8) && !(position_taken?(board, index))
    true
  else
    false
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def input_to_index(choice)
  return choice.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
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

def current_player(board)
  num_turns = turn_count(board)
  (num_turns.even?) ? "X" : "O"
end

def play(board)
  until(over?(board))
    turn(board)
  end

  if(draw?(board))
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # First vertical row
  [1,4,7],  # Second verical row
  [2,5,8],  # Last vertical row
  [0,4,8],  # Diagonal from top left
  [2,4,6]  # Diagonal from bottom left
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return win_combination
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    else
      false
    end
  end
  false
end

def full?(board)
  return board.none? {|position| position == " "}
end

def draw?(board)
  if(!won?(board) && full?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if(full?(board) || draw?(board) || won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  win = won?(board)
  if(win != false)
    return board[win[0]]
  end
end
