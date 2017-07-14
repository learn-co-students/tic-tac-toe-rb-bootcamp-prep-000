# Helper Methods
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
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    puts "Please try again!"
    turn(board)
  elsif valid_move?(board, index) && !full?(board)
    move(board, index, current_player(board))
    display_board(board)
  end
end



def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end

def turn_count(board)
  count = 0
  board.each do |taken|
    if taken == "X" || taken == "O"
      count += 1
    end
end
return count
end

def current_player(board)
  which_turn = turn_count(board).to_i
  if which_turn.even?
    return "X"
  elsif which_turn.odd?
    return "O"
  else
    nil
  end
end


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
  WIN_COMBINATIONS.each do |win_combo|
    if win_combo.all?{|i| board[i] == "X"} || win_combo.all?{|i| board[i] == "O"}
      return win_combo
    end
  end
  false
end



def full?(board)
  if board.detect { |e| e == "" } || board.detect { |e| e == " " }
    return false
  else
    true
  end
end

def draw?(board)
 if won?(board) === false && full?(board) === true
   return true
 else
   false
 end
end

def over?(board)
  if won?(board) != false || full?(board) === true || draw?(board) === true
    return true
  end
end

def winner(board)
  if won?(board) != false && over?(board) === true
    return board[won?(board)[0]]
  end
end
