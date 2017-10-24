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

def move(board, index, the_current_player)
  board[index] = the_current_player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
        move(board, index, current_player(board))
        display_board(board)
  else
    turn(board)
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |xo|
    if xo == "X" || xo == "O"
    counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2 == 1 ? "O" : "X"
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2], # Top row
[3,4,5], # Middle row
[6,7,8], # Bottom row
[0,3,6], # Left column
[1,4,7], # Middle column
[2,5,8], # Right column
[0,4,8], # Left diagonal
[2,4,6] # Right diagonal
]
# Define won?(board)

def won?(board)
        WIN_COMBINATIONS.detect do |winning_array|
          board[winning_array[0]] != " " && board[winning_array[0]] != "" &&
          board[winning_array[0]] == board[winning_array[1]] &&
          board[winning_array[1]] == board[winning_array[2]]
        end
end

def full?(board)
  board.all? do |letter|
    letter == "X" || letter == "O"
  end
end

def draw?(board)
  full?(board) == true && won?(board) == nil
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) == nil
    return nil
  else
    return board[won?(board)[1]]
  end
end

def play(board)
  while over?(board) == false
    turn(board)
  end

  if draw?(board) == true
      puts "Cat's Game!"
  end

  if won?(board) != nil
      puts "Congratulations #{winner(board)}!"
  end
end
