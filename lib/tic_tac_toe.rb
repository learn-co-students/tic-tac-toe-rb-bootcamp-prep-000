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

def input_to_index(index)
  index_i = index.to_i - 1
  return index_i
end

def move(board, index, character)
  board[index] = character
  return board
end

def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8)
    if position_taken?(board, index)
      return false
    else
      return true
    end
  else
    return nil
  end
end

def turn(board)
  puts "Please enter 1-9"
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
  index = 0
  loop do
    if position_taken?(board, index)
      count += 1
    end
    index += 1
    if index > 9 
      break
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return 'O'
  else
    return 'X'
  end
  # if turn_count(board) == 3
  #   return 'X'
  # end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if ((board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") || (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O") )
      return combo
    end
  end
  return false;
end

def full? (board)
  index = 0
  board.each do |cell|
    if !position_taken?(board, index)
      return false;
    end
    index += 1
  end
  return true
end

def draw?(board)
  if won?(board) == false
    if full?(board)
      return true
    else 
      return false
    end
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if !draw?(board) && over?(board)
    comboArray = won?(board)
    if board[comboArray[0]] == "X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end
end

def play(board)
    while !over?(board)
      turn(board)
      if won?(board) || draw?(board)
        break
      end
    end
    if won?(board)
      puts `Congratulations #{winner(board)}!`
    elsif draw?(board)
      puts'Cat\'s Game!'
    end
end