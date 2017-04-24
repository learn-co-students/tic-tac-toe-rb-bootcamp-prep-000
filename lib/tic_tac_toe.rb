#defines the possible winning combinations
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

#displays the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#convers user input to index
def input_to_index(input)
  input.to_i - 1
end

#fills position with token
def move(board, index, current_player)
  board[index] = current_player
end

#checks if position is taken
def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

#checks if move is valid
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

#one complete turn
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

#determines number of turns taken
def turn_count(board)
  turns = 0
  board.each do |position|
    if position != " "
      turns += 1
    end
  end
  return turns
end

#determines who the current player is based on the number of turns
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

#determines if a player won the game
def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    position_taken?(board, combination[0]) &&
    board[combination[0]] == board[combination[1]] &&
    board[combination[0]] == board[combination[2]]
  end
end

#determines if the board is full
def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

#determines if there is a draw
def draw?(board)
  !won?(board) && full?(board)
end

#determines if the game is over
def over?(board)
  won?(board) || draw?(board)
end

#determines who the winner is
def winner(board)
  if win_combination = won?(board)
    board[win_combination[0]]
  end
end

#executes game
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
