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

def move(array, index, char)
  array[index] = char
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board,index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  #iterate through winning combos and see if any of them are present on board
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] =="X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    end
    
    if board[combo[0]] =="O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  return false
end

def full?(board)
  counter = -1  
  board.all? do |i|
    position_taken?(board, counter += 1)    
  end
end

def draw?(board)
  if !won?(board)
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
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
