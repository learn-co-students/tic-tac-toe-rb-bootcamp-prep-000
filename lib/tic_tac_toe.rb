def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =[ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]

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

def move(board, index, character)
 board[index] = character
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
    turn(board)
  end
end
def turn_count(board)
  counter = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      counter += 1
    end  
  end
    return counter
end

def current_player(board)
  if turn_count(board) == 0
    return "X"
  elsif turn_count(board) % 2 ==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |number|
    win_index = number
     (board[win_index[0]] == "X"  && board[win_index[1]] == "X"  && board[win_index[2]] == "X") ||  (board[win_index[0]] == "O"  && board[win_index[1]] == "O"  && board[win_index[2]] == "O") 
     end
   end
  
def full? (board) 
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw? (board)
  if !won?(board) && full?(board)
    return TRUE
  else
    return FALSE
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return TRUE
  else
    return FALSE
  end
end

def winner(board)
  if won?(board)
    win_index = won?(board)
    return board[win_index[0]]
  else
    return nil
  end
end
# Define your play method below
def play(board)
  until over?(board)
  turn(board)
end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else 
    puts "Cat's Game!"
  
end
end
