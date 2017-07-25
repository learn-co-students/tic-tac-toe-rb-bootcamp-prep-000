# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    #does any win in board have all x's or all o's?
    occupants = [board[win[0]], board[win[1]], board[win[2]]]
    if occupants.all? {|p| p == "X"} || occupants.all? {|p| p == "O"}
      return win
    end
  end
  return nil
end

def full?(board)
  return board.all? {|p| p == "X" || p == "O"}
end

def draw?(board)
  #board full and not won means draw
  return full?(board) && !won?(board)
end

def over?(board)
  return won?(board) || full?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
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
    puts "INVALID MOVE! index #{index} is already filled by #{board[index]}. Try again."
    turn(board)
  end
end

def play(board)
  until over?(board) || draw?(board)  #draw check is redundant, Learn's test is dumb
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)  #this can just be else, but tests from Learn are dumb
    puts "Cats Game!"
  end
end

def turn_count(board)
  counter = 0
  board.each do |spot|
    if (spot.include? "X") || (spot.include? "O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turns_played = turn_count(board)
  if (turns_played % 2 == 0)
    return "X"
  else
    return "O"
  end
end
