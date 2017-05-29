
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
  board.each { |character| counter += 1 if character == "X" || character == "O" }
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.find do |combination|
    i1 = combination[0]
    i2 = combination[1]
    i3 = combination[2]
    p1 = board[i1]
    p2 = board[i2]
    p3 = board[i3]

    if p1 == p2 && p2 == p3 && (p1 == "X" || p1 == "O")
      true
    else
      false
    end
  end
end

def full?(board)
  board.all? { |character| character == "X" || character == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  won = won?(board)
  won ? board[won[0]] : nil
end

def play(board)

  until over?(board)
    turn(board)
  end

  winner = winner(board)
  if winner
    puts "Congratulations #{winner}!"
  else
    puts "Cats Game!"
  end
end
