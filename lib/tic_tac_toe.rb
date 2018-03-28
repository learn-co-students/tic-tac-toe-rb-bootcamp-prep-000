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

def input_to_index(input)
  input.to_i - 1
end

def move(board, idx, token)
    board[idx] = token
end

def position_taken?(board, idx)
  board[idx] == "X" || board[idx] == "O"
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
  board.each do |pos|
    if pos == "X" || pos == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  b_size = board.size - 1
  (0..b_size).each do |pos|
    if position_taken?(board, pos)
      marker = board[pos]
      WIN_COMBINATIONS.each do |combo|
        if combo[0] == pos
          if combo.all? {|i| board[i] == marker}
            return combo
          end
        end
      end
    end
  end
  false
end

def full?(board)
  board.all? {|pos| pos == "X" || pos == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
  false
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
  false
end

def winner(board)
  win = won?(board)
  if win
    return board[win[0]]
  end
end

def play(board)
  if !over?(board)
    turn(board)
    play(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end
end
