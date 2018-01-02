WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]  # M,iddle row
  # ETC, an array for each win combination
]

def display_board(board)
  print " #{board[0]} | #{board[1]} | #{board[2]} \n"
  print "-----------\n"
  print " #{board[3]} | #{board[4]} | #{board[5]} \n"
  print "-----------\n"
  print " #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(user_input)
  user_input.to_i-1
end

def move(board, index, character)
  board[index] = character
  board
end

def position_taken?(board, index)
  if  (board[index]== "" || board[index]== " " || board[index] == nil)
    false
  else
    true
  end
end

def valid_move?(board, index)
  if (index.between?(0,8) && !position_taken?(board, index))
    true
  else
    false
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
      turn(board)
    end
end



def turn_count(board)
  count = 0
  board.each do |position|
    if (position == "X" || position == "O")
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


def won?(board)
  WIN_COMBINATIONS.each do |combination|
    position_1 = board[combination[0]]
    position_2 = board[combination[1]]
    position_3 = board[combination[2]]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combination
    end
  end
  false
end

def full?(board)
  !board.include?(" ")
end

  def draw?(board)
    if won?(board) == false && full?(board)
      true
    else
      false
    end
  end

def winner(board)
  value = won?(board)
  if value != false
    board[value[0]]
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
   true
  else
    false
  end
end


def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  else
    puts "Cat\'s Game!"
  end
end
