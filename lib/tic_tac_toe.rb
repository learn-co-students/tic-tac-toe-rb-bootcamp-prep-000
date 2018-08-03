# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0, 1, 2],[3, 4, 5],[6, 7, 8],[0, 3, 6],[1, 4, 7],[2, 5, 8],[0, 4, 8],[2, 4, 6]]


def display_board(board)
  printRow(board[0], board[1], board[2])
  puts "-----------"
  printRow(board[3], board[4], board[5])
  puts "-----------"
  printRow(board[6], board[7], board[8])
end

def printRow(x, y, z)
  puts " #{x} | #{y} | #{z} "
end

def input_to_index(n)
  n.to_i - 1 
end
 
def move(board, pos, char)
  board[pos] = char
  return board
end

def valid_move?(board, i)
  if (position_taken?(board, i) == false) && (i < board.length) && i > -1
    return true
  else
    return false
  end
end 


def position_taken?(board, i)
  if board[i] == "X" || board[i] == "O"
    return true 
  else
    return false 
  end
end 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  char = current_player(board)
  if valid_move?(board, index)
    move(board, index, char)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do |i|
    i == " " ? next : turns += 1
  end
  return turns
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end 

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]) && board[combo[0]] != " "
      return combo
    end 
  end
  return false
end 

def full?(board)
  #if there are NO EMPTY SPACES
  board.none? { |i| i == " " }
end

def draw?(board)
  #if the board is FULL && nobody has WON
  full?(board) && !won?(board)
end

def over?(board)
  #if someone has WON, or it is DRAW
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board=[" ", " ", " ", " ", " ", " ", " ", " ", " "])
  #board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat\'s Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end 
end 