def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board) 
    puts "Congratulations #{winner(board)}!"
  else 
    puts "Cat's Game!"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, index, player)
  board[index] = player
end

def turn(board) 
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "I'm sorry, that is not a valid move."
    turn(board)
  end
end

def turn_count(board)
  board.reject{|space| space == " "}.length
end

def current_player(board)
  turn_count(board) % 2 == 1 ? "O" : "X"
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[0,4,8],[0,3,6],[1,4,7],[2,4,6],[2,5,8],[3,4,5],[6,7,8]]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    else 
      false
    end
  end 
  false
end

def full?(board) 
  (board.reject{|i| i == " "}.length ==9)
end

def draw?(board) 
  if !won?(board) && full?(board)
    return true
  end
  false
end

def over?(board) 
  if won?(board) || draw?(board) || full?(board)
    true
  end
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end