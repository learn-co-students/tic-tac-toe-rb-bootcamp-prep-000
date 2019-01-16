WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]
]

def display_board(b)
  puts " #{b[0]} | #{b[1]} | #{b[2]} "
  puts "-----------"
  puts " #{b[3]} | #{b[4]} | #{b[5]} "
  puts "-----------"
  puts " #{b[6]} | #{b[7]} | #{b[8]} "
end

def input_to_index(input)
  x = input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  if (0..8).include?(index) && board[index] == " "
    true
  end
end

def turn(board)
  system "clear"
  display_board(board)
  puts " "
  puts "Player #{current_player(board)}..."
  puts "Please enter 1-9:"
  input = gets.chomp
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
  board.each do |x|
    if x != " "
      count += 1
    end
  end
  count
end

def current_player(board)
  x = turn_count(board)
  (x%2==0) ? "X" : "O"
end

def won?(board)
  winner = nil
  WIN_COMBINATIONS.each do |wc|
    x1 = wc[0]
    x2 = wc[1]
    x3 = wc[2]

    pos1 = board[x1]
    pos2 = board[x2]
    pos3 = board[x3]

    if pos1 == "X" && pos2 == "X" && pos3 == "X"
      winner = wc
    elsif pos1 == "O" && pos2 == "O" && pos3 == "O"
      winner = wc
    end
  end
  winner
end

def full?(board)
  board.none?{|x| x == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  turn(board) until over?(board)
  if winner(board)
    system "clear"
    display_board(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    system "clear"
    display_board(board)
    puts "Cat's Game!"
  end
end
