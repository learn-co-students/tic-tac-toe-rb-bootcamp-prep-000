# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

# Helper Method
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-" * 11
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-" * 11
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(i)
  i.to_i - 1
end

def position_taken?(board, index)
  board[index]== "X" || board[index] == "O"
  #!(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def move(board, position, char)
  board[position] = char
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  char = current_player(board)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
  exit if turn_count(board) == 10
end

def turn_count(board)
  turns = 0
  board.each do |element|
    if element == 'X' || element == 'O'
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  win = false
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
      win = combination
    elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
      win = combination
    end
  end
  return win
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if won?(board)
    return false
  else
    full?(board)
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  win = nil
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
      win = "X"
    elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
      win = "O"
    end
  end
  return win
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
