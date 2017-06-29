
board = [" ", " ", " ", " ", " ", " ", " ", " ", " ",]

WIN_COMBINATIONS = [[0, 1, 2],[3, 4, 5],[6, 7, 8],[0, 3, 6],[1, 4, 7],[2, 5, 8],[0, 4, 8],[2, 4, 6]]

def display_board(board)
  a = board[0]
  b = board[1]
  c = board[2]
  d = board[3]
  e = board[4]
  f = board[5]
  g = board[6]
  h = board[7]
  i = board[8]
  puts " #{a} | #{b} | #{c} "
  puts "-----------"
  puts " #{d} | #{e} | #{f} "
  puts "-----------"
  puts " #{g} | #{h} | #{i} "
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  number = gets.strip
  index = input_to_index(number)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do | position |
    if position == "O" || position == "X"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def full?(board)
  !(board.any?{|i| i == " "})
end

def draw?(board)
  full?(board) && !won?(board)
end

def won?(board)
  WIN_COMBINATIONS.detect do | winArray |
    board[winArray[0]] == board[winArray[1]] && board[winArray[1]] == board[winArray[2]] && board[winArray[1]] != " "
  end
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  while !(over?(board))
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
