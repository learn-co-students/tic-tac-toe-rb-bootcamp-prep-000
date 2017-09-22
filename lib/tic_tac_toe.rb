WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
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

def move(board, position, mark)
  board[position] = mark
end

def position_taken?(board, position)
  !(board[position].nil? || board[position] == ' ')
end

def valid_move?(board, position)
  position.between?(0, 8) && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    mark = current_player(board)
    move(board, index, mark)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.select{ |move| ['X', 'O'].include?(move)}.count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.any? do |comb|
    result = comb.reduce('') do |string, mark|
      string << board[mark]
    end
    return comb if result == 'XXX' || result == 'OOO'
  end
end

def full?(board)
  board.any? { |m| [' ', '', nil].include?(m) } ? false : true
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board) ? true : false
end

def winner(board)
  winning_move = won?(board)
  board[winning_move.first] if winning_move
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
