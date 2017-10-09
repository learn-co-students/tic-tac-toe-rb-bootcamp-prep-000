
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

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  !(board[position] == " " || board[position].nil?)
end

def valid_move?(board, position)
  if (position < 0 || position > 8)
    false
  elsif position_taken?(board, position)
    false
  else true
  end
end

def turn(board)
  puts "Please enter a number from 1-9:"
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
  count = (board.select{|i| i != " "}).length
  return count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.select do |win_com|
    if (board[win_com[0]] == "X" && board[win_com[1]] == "X" && board[win_com[2]] == "X")
      return win_com
    elsif (board[win_com[0]] == "O" && board[win_com[1]] == "O" && board[win_com[2]] == "O")
      return win_com
    end
  end
  false
end

def full?(board)
  board.all?{|i| (i == "O" || i == "X")}
end

def draw?(board)
  (full?(board) && !won?(board)) ? true : false
end

def over?(board)
  ((won?(board) || full?(board) || draw?(board)) ? true : false)
end

def winner(board)
  if (won?(board))
    return board[won?(board)[0]]
  end
end

def play(board)
  while (over?(board) == false)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
