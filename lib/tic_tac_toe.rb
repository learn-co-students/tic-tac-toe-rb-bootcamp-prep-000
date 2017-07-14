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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  player = current_player(board)
  puts "Player #{player} please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each_index do |i|
    if position_taken?(board, i)
      count +=1
    end
  end
  count
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    "X"
  else
    "O"
  end
end

def position_indexer(board, player="X")
  position_indexes = []
  board.each_index do |i|
    if board[i] == player
      position_indexes << i
    end
  end
  position_indexes
end

def won?(board)
  xpos_index = position_indexer(board)
  opos_index = position_indexer(board, "O")

  WIN_COMBINATIONS.detect do |array|
    array.all? { |e| xpos_index.include?(e)} || array.all? { |e| opos_index.include?(e)}
  end
end

def full?(board)
  board.all? do |cell|
    cell == "X" || cell == "O"
  end
end

def draw?(board)
  if full?(board) && won?(board) == nil
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  won_result = won?(board)
  if won_result == nil
    nil
  else
    board[won_result[0]]
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
