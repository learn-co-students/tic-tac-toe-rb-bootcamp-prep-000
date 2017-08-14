# Helper Method
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS= [
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
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count=0
  board.each do |index|
    if index != " " && index != "" && index != nil
      count += 1
  end
end
return count
end

def current_player(board)
  player = "O"
  if(turn_count(board) % 2 == 0)
    player = "X"
  end
  return player
end


def won?(board)
  WIN_COMBINATIONS.each do |winCombo|
    positions = [board[winCombo[0]], board[winCombo[1]], board[winCombo[2]]]
    if positions[0] == positions[1] && positions[1] == positions[2]
      if positions[0] == "X" || positions[0] == "O"
        #win
        return winCombo
      end
    end
  end
  return false
end

def full?(board)
  board.all?{|i| i=="X" || i =="O"}
end

def draw?(board)
  if(won?(board)==false)
      if(full?(board))
          return true
      end
  end
  return false
end

def over?(board)
  if(draw?(board) || won?(board) || full?(board))
    return true
  end
  return false
end

def winner(board)
  if(won?(board).class == Array)
    return board[won?(board)[0]]
  end
end

def play(board)

  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations " + winner(board) + "!"
  else
    puts "What's here?"
  end
end
