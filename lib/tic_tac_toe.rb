WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(user_input)
  input = user_input.to_i - 1 
  return input
end

def move(board, index, token)
  board[index] = token
  return board
end

def valid_move?(board, index)
  if index.between?(0,8)
    if position_taken?(board, index)
      return FALSE
    else
      return TRUE
    end
  else 
    return FALSE
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == NIL
    return FALSE
  else
    return TRUE
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index) == TRUE
      board = move(board, index, player)
      display_board(board)
    else
      turn(board)
    end
end

def turn_count(board)
  turnCount = 0 
  board.each do |turn|
    if turn == "X" || turn == "O"
      turnCount += 1 
    end
  end
  return turnCount
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else
    return "O"
  end
end

def won?(board)
  winning_array = []
  WIN_COMBINATIONS.each do |wincombo|
    if board[wincombo[0]] == "X" && board[wincombo[1]] == "X" && board[wincombo[2]] == "X"
      winning_array = wincombo
    elsif board[wincombo[0]] == "O" && board[wincombo[1]] == "O" && board[wincombo[2]] == "O"
      winning_array = wincombo
    else
      winning_array = nil
    end
    if winning_array != nil
      return TRUE
    end
  end
  if winning_array == nil
    return FALSE
  end
end

def full?(board)
  full_board = board.none? do |index|
    index == " "
  end
  return full_board
end

def draw?(board)
  if won?(board) == TRUE
    return FALSE
  elsif full?(board) == TRUE
    return TRUE
  else
    return FALSE
  end
end

def over?(board)
  if won?(board) == TRUE
    return TRUE
  elsif draw?(board) == TRUE
    return TRUE
  else
    return FALSE
  end
end


def winner(board)
  WIN_COMBINATIONS.each do |wincombo|
    if board[wincombo[0]] == "X" && board[wincombo[1]] == "X" && board[wincombo[2]] == "X"
      return "X"
    elsif board[wincombo[0]] == "O" && board[wincombo[1]] == "O" && board[wincombo[2]] == "O"
      return "O"
    else
    
    end
  end
  return nil
end

def play(board)
  until over?(board) == TRUE do
    turn(board)
    won?(board)
  end
  
  if won?(board) == true
    winning_player = winner(board)
    puts "Congratulations #{winning_player}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
    