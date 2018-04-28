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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  if board[index] == " "
    return FALSE
  elsif board[index] == ""
  return FALSE
elsif board[index] == NIL
  return FALSE
elsif board[index] == "X" || "O"
  return TRUE
end
end

def valid_move?(board, index)
    if index.between?(0, 8) && position_taken?(board, index) == FALSE 
      return TRUE
    else
      return FALSE
    end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  else
    if turn_count(board) === 0 || turn_count(board).even?
      move(board, index, token = "X")
      display_board(board)
    elsif turn_count(board).odd?
      move(board, index, token = "O")
     display_board(board)
  end
end
end

def turn_count(board)
  turn_count = 0
  board.each do |index|
    if index === "X" || index === "O"
      turn_count += 1
    end
  end
  return turn_count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
    end
    if board = [" ", " ", " ", " ", " ", " ", " ", " ", " "] || draw?(board)
      return false
    end
  end
  
  def full?(board)
    board.all? {
      |i| i === "X" || i === "O"
    }
  end
  
  def draw?(board)
    !won?(board) && full?(board)
  end
  
  def over?(board)
    won?(board) || draw?(board) || full?(board)
  end
  
  def winner(board)
    if won?(board)
      winnerat = won?(board)
      winneratexplicit = winnerat[0]
      winnertoken = board[winneratexplicit]
      return winnertoken
    end
  end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end