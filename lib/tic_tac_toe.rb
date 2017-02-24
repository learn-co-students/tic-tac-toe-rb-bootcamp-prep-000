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

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
if position_taken?(board, index) == false && index.between?(0, 8)
return true
else
return false
end
end

def current_player(board)
   if turn_count(board) % 2 == 0
      "X"
    else
      "O"
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
  counter = 0
  board.each do |turn|
    if turn == "O" || turn == "X"
    counter += 1
  end
end
counter
end

def won?(board)
  WIN_COMBINATIONS.each do |winner|
    if board[winner[0]] == "X" && board[winner[1]] == "X" && board[winner[2]] == "X"
      return winner
    elsif board[winner[0]] == "O" && board[winner[1]] == "O" && board[winner[2]] == "O"
      return winner
    end
end
return false
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  win = won?(board)
  win ? board[win[0]] : nil
end

def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end
