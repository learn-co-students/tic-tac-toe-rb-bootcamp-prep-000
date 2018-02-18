WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
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
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
   turn_count(board) % 2 == 0 ? board = "X" : board = "O" 
  
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_0 = win_combination[0]
      pos_1 = board[win_index_0]
      
      win_index_1 = win_combination[1]
      pos_2 = board[win_index_1]
      
      win_index_2 = win_combination[2]
      pos_3 = board[win_index_2]
      
      if (pos_1 == "X" && pos_2 == "X" && pos_3 == "X") 
        return win_combination
        elsif
        (pos_1 == "O" && pos_2 == "O" && pos_3 == "O")
        return win_combination
      else
         FALSE
      end
      
    end
    FALSE
end

def full?(board)
   board.all? {|item| item == "X" || item == "O"}
  
end

def draw?(board)
 if !won?(board) &&  full?(board)
   return true
 else
   FALSE
 end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  #if it exists, catch the return value from the call to won? in player_won, return the board array with a call to the first method on player_won as the board element
  if player_won = won?(board)
    board[player_won.first]
  end 
      
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
    puts "Cat's Game!"
  end 
end