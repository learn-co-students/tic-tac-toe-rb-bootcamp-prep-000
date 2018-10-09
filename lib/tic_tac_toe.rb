WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
  ]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  actual = input.to_i - 1
  actual
end

def move(board, pos, char)
  board[pos] = char
end

def valid_move?(board, index)
   num = (0..8).to_a
  if num.include?(index)
    return true unless position_taken?(board, index)
  end
  false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    char = current_player(board)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  
  until over?(board) || full?(board)
    turn(board)
  end
  puts "Cat's Game!" if draw?(board)
  puts "Congratulations #{winner(board)}!" if won?(board)
end 

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |pos|
    return pos if board[pos[0]] == "X" && board[pos[1]] == "X" && board[pos[2]] == "X"
    return pos if board[pos[0]] == "O" && board[pos[1]] == "O" && board[pos[2]] == "O"
    end
  return nil if full?(board)
end

def full?(board)
  board.all?{ |el| el != " "}
end

def draw?(board)
  if full?(board)
   return true unless won?(board)
  else
   false
  end 
end

def over?(board)
  return true if draw?(board)
  return true if won?(board)
end

def winner(board)
  if won?(board)
   pos = won?(board)
    return board[pos[0]]
  else
    return nil
  end
end

def turn_count(board)
  occupied = 0
  board.each { |el| occupied += 1 unless el == " "}
  occupied
end

def current_player(board)
  turn = turn_count(board)
  if turn.odd?
    return "O"
  else
    return "X"
  end
end

