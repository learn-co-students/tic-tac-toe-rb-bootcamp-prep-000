# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
                    [0,1,2],  #top row
                    [3,4,5],  #mid row
                    [6,7,8],  #bottom row
                    [0,3,6],  # 1st col
                    [1,4,7],  # 2nd col
                    [2,5,8],  # 3rd col
                    [0,4,8],  # 1st diagonal
                    [2,4,6],  # 2nd diagonal
                  ]
# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  i=0;
  puts " #{board[i]} | #{board[i+1]} | #{board[i+2]} "
  puts "-----------"
  i=3;
  puts " #{board[i]} | #{board[i+1]} | #{board[i+2]} "
  puts "-----------"
  i=6;
  puts " #{board[i]} | #{board[i+1]} | #{board[i+2]} "
end

def input_to_index(pos)
  pos.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if index.between?(0,8)
    if position_taken?(board, index)
      false
    else
      true
    end
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "invalid"
    turn(board)
  end
end

def turn_count(board)
  i = 0
  board.each do |char|
    i = i + 1 if char == "X" || char == "O"
  end
  return i
end

# Badass method using string
#def turn_count(board)
#  counter = 0
#  board.each do |pos|
#    pos =~ /[XO]/ ? counter += 1 : nil
#  end
#  return counter
#end

def current_player(board)
  turn_num = turn_count(board)
  if turn_num == 0
    return "X"
  else
    if turn_num % 2 == 0
      return "X"
    else
      return "O"
    end
  end
end

def won?(board)
  WIN_COMBINATIONS.each { |x|
    if ((board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X") || (board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O"))
      return x
    else
      false
    end
  }
  board.any?{|player| player == "X" || player == "O"}
  if full?(board)
    false
  end
end

def full?(board)
  board.none? { |x|
    x == " " || x == ""
  }
end

def draw?(board)
  if full?(board)&& !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  winner = won?(board)
  if winner.kind_of?(Array)
    return board[winner[0]]
  else
    nil
  end
end

def play(board)
  while !over?(board) do
    turn(board)
    if draw?(board)
      break
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
