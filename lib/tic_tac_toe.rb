WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(entry)
  index = entry.to_i - 1 
end

def move(board, index, input)
  board[index] = input
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    TRUE
  else
    FALSE
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "That is not a valid move"
    turn(board)
  end
end

def turn_count(board) 
  counter = 0 
  board.each { | position |
    if (position == 'X' || position == 'O')
      counter += 1 
    end
  }
  return counter
end

def current_player(board)
  counter = turn_count(board)
  counter % 2 == 0 ? player = 'X' : player = 'O'
end 

def won?(board)
  WIN_COMBINATIONS.each { | combination |
    if (board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] && position_taken?(board, combination[0]))
      return combination
    end
  }
    
  return FALSE
end

def full?(board)
  board.each { | index |
    if (index == " " || index == nil)
      return FALSE
    else
      TRUE
    end
  }
end

def draw?(board)
  if (full?(board) && !won?(board))
    TRUE
  else
    FALSE
  end
end

def over?(board)
  if (won?(board) || draw?(board))
    TRUE
  else
    FALSE
  end
end

def winner(board)
  if (won?(board))
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until (over?(board)) do
    turn(board)
  end
  
  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif (draw?(board))
    puts "Cat's Game!"
  end
end