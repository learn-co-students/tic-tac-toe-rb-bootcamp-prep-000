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

def display_board(board_array=[" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts " #{board_array[0]} | #{board_array[1]} | #{board_array[2]} \n-----------\n #{board_array[3]} | #{board_array[4]} | #{board_array[5]} \n-----------\n #{board_array[6]} | #{board_array[7]} | #{board_array[8]} \n"
end

def input_to_index(input)
  if (!input.to_i)
    return -1
  else
    return input.to_i - 1
  end
end

def move(board, index, char)
  board[index] = char
end

def position_taken? (board, index)
  if (board[index] == "X" || board[index] == "O")
    return true
  else
    return false
  end
end

def valid_move?(board, index)
  if(index >=0 && index <=9 && !position_taken?(board, index))
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if(valid_move?(board, index))
    char = current_player(board)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  filled_board  = board.select do |input|
    input == "X" || input == "O"
  end
  return filled_board.length
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    (board[win_combination[0]]=="X" && board[win_combination[1]]=="X" && board[win_combination[2]]=="X") || (board[win_combination[0]]=="O" && board[win_combination[1]]=="O" && board[win_combination[2]]=="O")
  end
end

def full?(board)
  board.all? { |input|   input == "X" || input=="O"}
end

def draw?(board)
  if(!won?(board) && full?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if(won?(board) || draw?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if(won?(board))
    return board[won?(board)[0]]
  end
  return
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end

end
