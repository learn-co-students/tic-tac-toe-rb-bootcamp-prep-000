WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #diagonal back
  [6,4,2], #diagonal forward
]

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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# def turn(board)
#   puts "Please enter 1-9:"
#   input = gets.strip
#   index = input_to_index(input)
#   if valid_move?(board, index)
#     move(board, index, current_player)
#     display_board(board)
#   else
#     turn(board)
#   end
# end


def turn(board)
  puts "Please enter 1-9:"
  i = gets.strip
  index = input_to_index(i)
  m = valid_move?(board, index)
  if m == true
    move(board, index, current_player(board))
  else m == false
    until m == true
      puts "Sorry, that was an invalid move. Please enter 1-9:"
      display_board(board)
      i = gets.strip
      index = input_to_index(i)
      m = valid_move?(board, index)
      move(board, index, current_player(board))
    end
  end
end

def turn_count(board)
  count = 0
  board.each do |i|
    if i == "X" || i == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    result = []
    win_combination.each do |i|
      result << board[i]
    end
    if result == ["X","X","X"] || result == ["O","O","O"]
      return win_combination
    end
  end
    return false
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

def draw?(board)
  (full?(board) && !won?(board)) ? true : false
end

def over?(board)
  (won?(board) || draw?(board)) ? true : false
end

def winner(board)
  if won?(board)
    test = won?(board)[0]
    # board[test] == "X" ? "X" : "O"
    if board[test] == "X"
      return "X"
    elsif board[test] == "O"
      return "O"
    end
  else
    return nil
  end
end


def play(board)
  until over?(board) == true
    display_board(board)
    turn(board)
  end
  if draw?(board) == true
       puts "Cat's Game!"
  else won?(board)
     puts "Congratulations #{winner(board)}!"
   end
end
