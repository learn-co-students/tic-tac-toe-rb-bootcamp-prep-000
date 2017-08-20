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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    player = "X"
  else
    player = "O"
  end
end

def won?(board)
  winning = WIN_COMBINATIONS.any? do |win|
    (board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X") || (board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O")
  end
  if winning == true
    winboard = WIN_COMBINATIONS.select do |win|
      (board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X") || (board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O")
    end
    winboard[0]
  end
end

def full?(board)
  board.all? do |index|
    index == "X" || index == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winningboard = won?(board)
  if winningboard != nil
    winner = board[winningboard[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) != nil
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end
