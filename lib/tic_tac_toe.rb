
WIN_COMBINATIONS =
[
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
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(input = gets.strip)
  if !valid_move?(board,index)
    turn(board)
  else
    move(board, index, token = current_player(board))
  end
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "O" || token == "X"
      counter +=1
    end
  end
    counter
  end

  def current_player(board)
    if turn_count(board) % 2 == 0
      "X"
    else
      "O"
    end
  end

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X" ||
    board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
  end
end

def full?(board)
  board.none? do |token|
    token == " "
  end
end

def draw?(board)
  if won?(board) || !full?(board)
    false
  else
    true
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
  board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
      turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
