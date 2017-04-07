WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

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

def display_board(board)
 line = "-----------"
 puts " #{board[0]} | #{board[1]} | #{board[2]} "
 puts line
 puts " #{board[3]} | #{board[4]} | #{board[5]} "
 puts line
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
  current_player = current_player(board)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
turn_count = 0
  board.each do | turn |
    if turn == "X" || turn == "O"
      turn_count += 1
    end
  end
  turn_count
end

def current_player(board)
current_player = nil
  if turn_count(board) % 2 == 0
    current_player = "X"
  elsif turn_count(board) % 2 != 0
    current_player = "O"
  end
  current_player
end

def won?(board)
  no_win = nil
  if board.all?{|space| space == " "}
    false
  else
    WIN_COMBINATIONS.each do |win|
      if win.all?{|index| board[index] == "X"}
        return win
      elsif win.all?{|index| board[index] == "O"}
        return win
      else
        no_win = true
      end
    end
  end
  if no_win == true
    return false
  end
end

def full?(board)
  if board.all?{|space| space == "X" || space == "O"}
    !won?(board)
  end
end

def draw?(board)
  full = full?(board)
  won = won?(board)
  if full && !won
    true
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    nil
  else
    index = won?(board)[0]
    return board[index]
  end
end
