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

def turn_count(board)
  turn = 0
  board.each {|t| turn += 1 if t != " "}
  turn
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    combo = win_combination.map { |x| board[x] }
    return win_combination if combo.all? { |w| w == "X" } || combo.all? { |w| w == "O" }
  end
  return false
end

def full?(board)
  board.all? { |x| x == "X" || x == "O" }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  winning_combination = won?(board)
  return nil unless winning_combination
  board[winning_combination[0]]
end

def valid_move?(board, idx)
  return true if (0..8).include?(idx) && !position_taken?(board, idx)
  false
end

def position_taken?(board, idx)	
  return true unless (board[idx] == " " || board[idx] == "" || board[idx] == nil)
  false
end

def input_to_index(number)
   number.to_i - 1
end

def move(board, idx, player)
  board[idx] = player
  return board
end 

def display_board(board)
  separator = "-" * 11
  printed_board = board.map { |tile| " #{tile} " }
    .map.with_index { |tile, idx| idx % 3 === 1 ? "|#{tile}|" : tile }
    .map!.with_index { |tile, idx| [2,5].include?(idx) ? "#{tile}\n#{separator}\n" : tile }
    .join
  puts printed_board
end

def turn(board)
  puts "Please enter 1-9:"
  answer = gets.strip
  idx = input_to_index(answer)
  if valid_move?(board, idx)
    move(board, idx, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!"if won?(board)
  puts "Cat's Game!" if draw?(board)
end