WIN_COMBINATIONS = [
  [0,1,2],
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

def input_to_index(input)
  input.to_i - 1
end

def move(board,index,char)
  if valid_move?(board,index)
    board[index] = "#{char}"
  end
end

def position_taken?(board,index)
  if board[index] == "X" || board[index] == "O"
    return true
  end
  return false
end

def valid_move?(board,index)
  if index.between?(0,8) && !position_taken?(board,index)
    return true
  end
  return false
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |array|
    if (board[array[0]] == "X" && board[array[1]] == "X" && board[array[2]] == "X") || (board[array[0]] == "O" && board[array[1]] == "O" && board[array[2]] == "O")
      return array
    end
  end
  return false
end

def full?(board)
  return !board.any?{|entry| entry == " " || entry == ""}
end

def draw?(board)
  return (full?(board) && !won?(board))
end

def over?(board)
  return (won?(board) || full?(board) || draw?(board))
end

def winner(board)
  if !won?(board)
    return nil
  end
  return board[won?(board)[0]]
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    person = winner(board)
    puts "Congratulations #{person}!"
  end

  if draw?(board)
    puts "Cat's Game!"
  end
end
