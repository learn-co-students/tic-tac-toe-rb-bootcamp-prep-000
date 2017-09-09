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
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |count|
    if count == "X" || count == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  move = turn_count(board)
  move % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    index_1 = win[0]
    index_2 = win[1]
    index_3 = win[2]
    if board[index_1] == "X" && board[index_2] == "X" && board[index_3] == "X"
      return win
    elsif board[index_1] == "O" && board[index_2] == "O" && board[index_3] == "O"
      return win
    end
  end
  false
end

def full?(board)
  board.all? { |item| item == "X" || item == "O"}
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  draw?(board) || won?(board) ? true : false
end

def winner(board)
  if won?(board)
    win = won?(board)
    index = win[0]
    return board[index]
  end
  nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
