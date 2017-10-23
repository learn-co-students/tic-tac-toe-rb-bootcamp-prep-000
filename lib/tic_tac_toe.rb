
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #mid row
  [6,7,8], #bot row
  [0,3,6], #left col
  [1,4,7], #mid col
  [2,5,8], #right col
  [0,4,8], #top left to bot right
  [2,4,6]  #top right to bot left
]

def display_board(board)

puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def input_to_index(input)
  input = input.to_i

  input.between?(1,9) ? input - 1 : -1
end

def move(board, pos, token)
  board[pos] = token
end

def position_taken?(board, index)
  pos = board[index]
  !(pos == "" || pos == " " || pos.nil?)
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
end

def turn(board)
  puts "Enter a number 1-9"
  index = input_to_index(gets.strip)
  good_move = false
  until good_move
    good_move = valid_move?(board, index)
    if(good_move)
      move(board, index, current_player(board))
    else
      puts "Enter a number 1-9 thats not taken please"
      index = input_to_index(gets.strip)
    end
  end

end

def turn_count(board)
  nonempty_positions = board.select do |this_cell|
    !(this_cell == " " || this_cell == "" || this_cell.nil?)
  end
  nonempty_positions.size
end

def current_player(board)
  turn_count(board) % 2 == 0? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_con|
    board[win_con[0]] == board[win_con[1]] && board[win_con[1]] == board[win_con[2]] && position_taken?(board, win_con[0])
  end
end

def full?(board)
  board.none? do |pos|
    pos == "" || pos == " " || pos.nil?
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)

  until(over?(board))
    turn(board)
  end

  winner = winner(board)

  if(winner)
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end

end
