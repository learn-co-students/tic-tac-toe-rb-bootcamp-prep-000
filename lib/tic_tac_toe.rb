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

def move(board, index, player_token)
  board[index] = player_token
end

def valid_move?(board, index)
  return !position_taken?(board, index) && index.between?(0,8)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  return board.select{|c| c == "X" || c == "O"}.length
end

def current_player(board)
  return turn_count(board)%2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

#-----------------------------------------



def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if position_taken?(board, combo[0]) &&
       position_taken?(board, combo[1]) &&
       position_taken?(board, combo[2]) &&
       board[combo[0]] == board[combo[1]] &&
       board[combo[1]] == board[combo[2]]
      return combo
    end
  end
  return false
end

def full?(board)
  return !board.any?{|c| c == " "}
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return won?(board) || draw?(board)
end

def winner(board)
  if combo = won?(board)
    return board[combo[0]]
  end
  return nil
end

# Define your play method below

def play(board)
  
  until over?(board)
    turn(board)
  end
  
  if w = winner(board)
    puts "Congratulations #{w}!"
  else
    puts "Cat's Game!"
  end
end