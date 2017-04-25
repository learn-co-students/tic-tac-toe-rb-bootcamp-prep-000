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

# Gets and validates the user input
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
    if pos != " " and pos != ""
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
]

$x=[]
def won?(board)
  y = []
  WIN_COMBINATIONS.each do |win_combo| # ex [0,1,2]
    if win_combo.all?{|i| board[i] == "X"} || win_combo.all?{|i| board[i] == "O"}
      y = win_combo
    end
  end
  $x=y
  if y == []
     return false
  else
     return true
  end
end

def full?(board)
  if board.none?{|i| i == " "}
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

def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  elsif full?(board) == false
    false
  end
end

def winner(board)
  if won?(board)
    if $x.all?{|i| board[i] == "X"}
      "X"
    elsif $x.all?{|i| board[i] == "O"}
      "O"
    end
  end
end


# Define your play method below
def play(board)
  until turn_count(board) == 10
    if over?(board) == false
      display_board(board)
      turn(board)
    elsif over?(board) == true
      if draw?(board) == true
        puts "Cats Game!"
        return
      elsif won?(board) == true
        if winner(board) == "X"
          puts "Congratulations X!"
          return
        elsif winner(board) == "O"
          puts "Congratulations O!"
          return
        end
      end
      break
    end
  end
end
