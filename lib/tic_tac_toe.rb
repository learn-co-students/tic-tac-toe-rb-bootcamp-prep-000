# Constant listing win possibilities
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6]
]

# Method that prints current board representation
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Method that converts user input to array index number
def input_to_index(user_input)
  user_input = user_input.to_i - 1
end

# Method that updates the board with character's input move
def move(board, index, char)
  board[index] = char
  return board
end

# Method for evaluating whether position has current input or not
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Method for checking whether current move is valid - whether it is within
# the board or if the position is already taken
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Method for encapsulating the logic of a single complete turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  char = current_player(board)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    puts "Please enter 1-9:"
    turn(board)
  end
end

# Method for determining the number of turns played
def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns+=1
    end
  end
  return turns
end

# Method for determining whose turn it is
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Method for determining if there is a win present on the board
def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] == board[combination[1]] &&
    board[combination[1]] == board[combination[2]] &&
    position_taken?(board, combination[0])
  end
end

# Method for determining if the board has any moves left
def full?(board)
  board.none?{|i| i == " "}
end

# Method for determining if there is a draw present on the board
def draw?(board)
  !won?(board) && full?(board)
end

# Method for determining if the game is over
def over?(board)
  won?(board) || full?(board) || draw?(board)
end

# Method for determining if the game was won by a player
def winner(board)
  if win_combination = won?(board)
    board[win_combination.first]
  end
end

# Main method responsible for key game loop
def play(board)
  # Until the game is over, take turns
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
