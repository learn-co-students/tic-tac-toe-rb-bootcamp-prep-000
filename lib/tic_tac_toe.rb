def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end 

def move(board, index, character)
  board[index] = character
end 

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end 
end 

def on_board?(index)
  if index.between?(0, 8)
    return true
  else
    return false
  end 
end 

def valid_move?(board, index)
  if !position_taken?(board, index) && on_board?(index)
    return true
  else
    return false
  end 
end 

def turn(board)
  puts "Please choose a number 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  
  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0 
  
  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end 
  end 
  
  return turns
end 

def current_player(board)
  turns = turn_count(board)
  
  if turns % 2 == 0 
    player = "X" 
  else 
    player = "O" 
  end 
  
  return player 
end 

WIN_COMBINATIONS = [
  [0, 1, 2], #Top row
  [3, 4, 5], #Middle row 
  [6, 7, 8], #Bottom row
  [0, 3, 6], #Left column
  [1, 4, 7], #Middle column 
  [2, 5, 8], #Right column
  [0, 4, 8], #Top left to bottom right
  [2, 4, 6]  #Bottom left to top right
  ]
  
def won?(board)
  WIN_COMBINATIONS.each { |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
    
  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]
    
  if position_1 == "X" &&
    position_2 == "X" &&
    position_3 == "X"
      
    return win_combination
      
  elsif position_1 == "O" &&
    position_2 == "O" &&
    position_3 == "O"
    
    return win_combination
  end 
  }
  
  return false 
end 

def full?(board)
  board.all? { |index| index == "X" || index == "O" }
end 
  
def draw?(board)
  if full?(board) && !won?(board)
    return true 
  else 
    return false
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
  index = won?(board)
  
  if index == false 
    return nil 
  else 
    if board[index[0]] == "X"
      return "X"
    else 
      return "O"
    end 
  end 
end

def play(board)
  until over?(board) == true 
    turn(board)
  end 
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end 
end 