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

def won?(board)
  won = WIN_COMBINATIONS.find do |combo|
    pieces = combo.map { |pos| board[pos] }
    pieces.uniq.length == 1 && position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? { |piece| piece == 'X' || piece == 'O' }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board)
end

def winner(board)
  won = won?(board)
  won.nil? ? nil : board[won[0]]
end

def turn_count(board)
  board.reduce(0) { |sum, piece| sum += (piece == 'X' || piece == 'O') && 1 || 0 }
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

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

def turn(board, char = 'X')
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
    return char == 'X' ? 'O' : 'X'
  else
    turn(board)
  end
end

def play(board)
  char = 'X'
  until over?(board)
    char = turn(board, char)
    if draw?(board)
      break
    end
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end