# Helper Method
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
  i = 0
  board.each do |el|
    i += 1 if el == "X" || el == "O"
  end
  i
end

def current_player(board)
  turn_count(board).even? ? "X":"O"
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    if (comb.all? {|el| board[el] == "X"}) || (comb.all? {|el| board[el] == "O"})
      return comb
    end
  end
  false
end

def full?(board)
  board.all? {|el| el == "X" || el == "O"}
end

def draw?(board)
  won?(board) || !full?(board) ? false:true
end

def over?(board)
  won?(board) || draw?(board) ? true:false
end

def winner(board)
  won?(board) ? board[won?(board)[0]]:nil
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
