WIN_COMBINATIONS = [
  [0,1,2], #top row win
  [3,4,5], #middle row win
  [6,7,8], #bottom row win
  [0,4,8], #top left diagonal win
  [2,4,6], #top right diagonal win
  [0,3,6], #left column win
  [1,4,7], #middle column win
  [2,5,8] #right column win
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-" * 11
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-" * 11
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(s)
  return s.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == nil
    return false
  else return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index >= 0 && index < 9
    return true
  else return false
  end
end

def turn(board)
  puts "Please enter the position you'd like to play on (1-9)"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Please reenter your position (1-9)"
    input = gets.chomp
  end
end

def turn_count(board)
  return board.count("X") + board.count("O")
end

def current_player(board)
  return "O" if turn_count(board).odd?
  return "X"
end

def won?(board)
  WIN_COMBINATIONS.each do |x|
    win_index1 = x[0]
    win_index2 = x[1]
    win_index3 = x[2]

    if position_taken?(board, win_index1) == true && board[win_index2] == board[win_index1] && board[win_index3] == board[win_index1]
      return x
    end
  end
  return false
end

def full?(board)
  board.all? do |x| x == "X" || x == "O" end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) == true || won?(board) != false
    return true
  else return false
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end
