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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end

  if( won?(board) )
    puts "Congratulations #{winner(board)}!"
  elsif( draw?(board) )
    puts "Cats Game!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move( board, index, current_player(board) )
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each { |field| if( field == "X" || field == "O") then counter += 1 end }
  return counter
end

def current_player(board)
  (turn_count(board) % 2 == 0)? "X" : "O"
end
# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
  [6,4,2]
]

def won?(board)
 candidates = []
  WIN_COMBINATIONS.each do |comb|
    if comb.all? { |el| position_taken?(board,el) }
      candidates << comb
    end
  end

  candidates.each do |candidate|
    if candidate.all? { |el| board[el] == "X"}
      return candidate
    elsif candidate.all? { |e| board[e] == "O" }
      return candidate
    end
  end
  return false
end

def full?(board)
  if board.all? { |e| (e != " " && e != "" && e != nil) }
    return true
  end
  return false
end

def draw?(board)
  if( !won?(board) && full?(board ))
    return true
  end
  return false
end

def over?(board)
  if( won?(board) || draw?(board) || full?(board) )
    return true
  end
  return false
end

def winner(board)
  won = won?(board)
  if( won )
    return board[won[0]]
  end
  return nil
end
