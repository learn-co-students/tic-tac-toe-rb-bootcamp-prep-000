WIN_COMBINATIONS = [   # An array for each win combination
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6], # 1st Column
  [1,4,7], # 2nd Column
  [2,5,8], # 3rd Column
  [0,4,8], # 1st Diagnal
  [2,4,6] # 2nd Diagnal
]
def play(board)
  while !over?(board)
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  end
  if draw?(board)
    puts "Cat's Game!"
  end

end
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def input_to_index(input)
  index = input.to_i - 1
end
def move(board, index, character)
  board[index] = character
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
  if turn_count(board).odd?
    character = "O"
  else
    character = "X"
  end
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    puts "Please enter 1-9:"
    input = gets.strip
  end
end
def turn_count(board)
  taken_spaces = 0
  board.each do |space|
    if space == "X" || space == "O"
      taken_spaces += 1
    end
  end
  taken_spaces
end
def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end
def won?(board)
  WIN_COMBINATIONS.detect do |sequence|
    board[sequence[0]] == board[sequence[1]] &&
    board[sequence[1]] == board[sequence[2]] &&
    position_taken?(board, sequence[0])
  end
end
def full?(board)
  board.all? {|character| character == "X" || character == "O" }
end
def draw?(board)
    full?(board) && !won?(board) #DRAW CONDITION
end
def over?(board)
  if draw?(board)
    return true
  elsif won?(board)
    return true
  end
end
def winner(board)
  if x = won?(board)
    board[x.first]
  end
end
