WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == 'X' || space == 'O'
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  players = ["X","O"]
  players.each do |player|
    WIN_COMBINATIONS.each do |combination|
      if board[combination[0]] == player && board[combination[1]] == player && board[combination[2]] == player
        return combination
      end
    end
  end
  nil
end

def full?(board)
  board.all? do |cell|
    !(cell.nil? || cell == " ")
  end
end

def draw?(board)
  if won?(board) != nil
    false
  elsif !full?(board)
    false
  else
    true
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  winpos = won?(board)
  if winpos
    board[winpos[0]]
  else
    winpos
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
