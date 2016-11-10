board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

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

def input_to_index(position)
  position.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  return false if board[index] == " "
  return true if board[index] != " "
end

def valid_move?(board, index)
  index.between?(0, 8) && board[index] == " "
end

def turn(board)
  puts "Enter your move (1-9):"
  position = gets.strip
  index = input_to_index(position)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    while !valid_move?(board, index)
      puts "That is not a valid move! - Try again!"
      position = gets.strip
      index = input_to_index(position)
    end
    move(board, index, token = "X")
    display_board(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |x|
    counter+= 1 if x == "X" or x == "O"
  end
  counter
end

def current_player(board)
  return "X" if turn_count(board).even?
  return "O" if turn_count(board).odd?
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    w1 = win_combination[0]
    w2 = win_combination[1]
    w3 = win_combination[2]

    p1 = board[w1]
    p2 = board[w2]
    p3 = board[w3]

    if p1 == "O" && p2 == "O" && p3 == "O"
      return win_combination
    elsif p1 == "X" && p2 == "X" && p3 == "X"
      return win_combination
    end
  end
  return false
end

def full?(board)
  board.all? do |check|
    check == "X" || check == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    x = won?(board)
    board[x.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  puts "Cats Game!" if draw?(board)
  puts "Congratulations #{winner(board)}!" if won?(board)
end
