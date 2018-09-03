WIN_COMBINATIONS = (0...9).each_slice(3).to_a
WIN_COMBINATIONS.concat WIN_COMBINATIONS[0].zip *WIN_COMBINATIONS[1..-1]
WIN_COMBINATIONS << [0,4,8] << [6,4,2]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n" \
       "-----------\n" \
       " #{board[3]} | #{board[4]} | #{board[5]} \n" \
       "-----------\n" \
       " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def position_taken?(board, index)
  if board[index].nil?
    false
  else
    board[index].count('XO') > 0
  end
end

def move(board, index, token)
  board[index] = token
end

def input_to_index(input)
 input.strip.to_i - 1
end

def turn(board)
  spot = 0
  loop do
    puts "Please enter 1-9:"
    spot = input_to_index gets.chomp
    break if valid_move?(board, spot)
  end
  # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/6745
  move(board, spot, current_player(board))
  display_board(board)
end

def play(board)
  loop do
    if over?(board)
      break
    end
    turn(board)
  end

  pl = winner(board)
  phrases = {
    "X" => "Congratulations X!",
    "O" => "Congratulations O!",
    nil => "Cat's Game!"
  }

  puts phrases[pl]
end

def turn_count(board)
  board.join.count "XO"
end

def current_player(board)
  "XO"[turn_count(board) % 2]
end

def won?(board)
  WIN_COMBINATIONS.find {|combo|
    ["XXX","OOO"].include? combo.map{|i| board[i]}.join
  }
end

def full?(board)
  board.join.count("XO") == board.size
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if !won? board
    nil
  elsif board.join.count("X") > board.join.count("O")
    "X"
  else
    "O"
  end
end
