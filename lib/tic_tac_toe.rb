def display_board(b)
puts " #{b[0]} | #{b[1]} | #{b[2]} "
puts "-----------"
puts " #{b[3]} | #{b[4]} | #{b[5]} "
puts "-----------"
puts " #{b[6]} | #{b[7]} | #{b[8]} "
end

def input_to_index(p)
  pos = p.to_i - 1
end

def move(board, pos, xo)
  board[pos] = xo
end

def valid_move?(board, move)
  index = move-1
  if position_taken?(board, move) == false && move.between?(0,8) == true
    true
  else
    false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.

def position_taken?(board, position)
  if board[position] == "X"
    true
  elsif board[position] == "O"
    true
  elsif board[position] == " " || board[position] == ""
    false
  else board[position] == nil
    false
  end
end

def turn_count(board)
  filled = board.select do |space|
    space == "X" || space == "O"
  end
  filled.length
end

def current_player(board)
  if (turn_count(board)+1) % 2 == 0
    "O"
  else
    "X"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  pos = gets.strip
  index = input_to_index(pos)
  xo = current_player(board)
  if valid_move?(board, index) == true
    move(board, index, xo)
    display_board(board)
  else
    turn(board)
  end
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]
$the_winner = ""

def won?(board)
  is_winner = false
  WIN_COMBINATIONS.each do |combo|
      if combo.all? do |pos|
        board[pos] == "X"
      end
      is_winner = true
    elsif combo.all? do |pos|
        board[pos] == "O"
      end
      is_winner = true
    else
      next
    end
  end
  if is_winner == true
    xwin = WIN_COMBINATIONS.select do |combo|
        combo.all? do |pos|
          board[pos] == "X"
        end
      end
    owin = WIN_COMBINATIONS.select do |combo|
        combo.all? do |pos|
          board[pos] == "O"
        end
      end
      if xwin == []
        $the_winner = "O"
        owin[0]
      else
        $the_winner = "X"
        xwin[0]
      end
  else
    false
  end
end

def full?(board)
  board.all? do |pos|
    pos == "X" || pos == "O"
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  elsif !full?(board) && !won?(board)
    false
  elsif won?(board)
    false
  else
    false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true
    true
  end
end

def winner(board)
  if draw?(board) || !over?(board)
    nil
  else
    $the_winner
  end
end

def play(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end
