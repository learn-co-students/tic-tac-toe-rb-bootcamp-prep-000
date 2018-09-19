$game_winner = nil

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (int)
  pos = int.to_i() - 1
  if pos >=0 && pos <9
    return pos
  else
    return -1
  end
end

def player_move(board,ind,player)
  if board[ind] == nil || board[ind] == " "
    board[ind] = player
  end
end

def position_taken?(board,index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,ind)
  if ind<9 && ind >=0
    if position_taken?(board,ind)
    return false
    else return true
    end
  end
  return false
end

def turn (board)
  puts "Please enter position:"
  inp = gets.strip
  inp = input_to_index(inp)
  while inp == -1 || position_taken?(board,inp) do
    puts "Invalid. Try again: "
    inp = gets.strip
    inp = input_to_index(inp)
    
  end

  player_move(board,inp,current_player(board))
  display_board(board)
  
end

def turn_count (board)
  counter = 0
  board.each do |pos|
    if pos == "O" || pos == "X"
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  win_array_X = []
  win_array_O = []
  counter = 0
  counter_X = 0
  counter_O = 0  
  while counter < 9 do
    if board[counter] == "X"
      win_array_X[counter] = counter
    
    elsif board [counter] == "O"
      win_array_O[counter] = counter
    end
      
      counter +=1
  end
  
  match_array_X = []
  match_array_O = []
  WIN_COMBINATIONS.each do |combo|
    combo.each do |ind|
      if win_array_X[ind] == ind
        match_array_X.push(true)
      end
      if win_array_O[ind] == ind
        match_array_O.push(true)
      end
    end
    
    if match_array_X[0] == true && match_array_X[1] == true && match_array_X[2] == true
      $game_winner = "X"
      return combo
    else
      match_array_X.clear()
    end
    if match_array_O[0] == true && match_array_O[1] == true && match_array_O[2] == true
      $game_winner = "O"
      return combo
    else
      match_array_O.clear()
    end
    
  end
     
  
  return nil
#returns nil or winning combo if won  
end

def full? (board)
  counter = 0
  board.each do
    if !position_taken?(board,counter)
      return false
    end
    counter +=1
  end
  return true
#return true if all positions filled
end

def draw? (board)
  if full?(board) == true && won?(board) == nil
    return true
  else
    return false
  end
#returns true if board is full but not won
end

def over?(board)
  if winner(board) != nil || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
#returns true if board won, draw, or full
end

def winner (board)
  if won?(board) == nil
    return nil
  else
    return $game_winner
  end
#returns the winner, x or o  
end

def play (board)
  won?(board)
  won?(board)
  puts ("Congratulations X!")
  puts ("Congratulations O!")
  while over?(board) == false do
    turn(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    end
  end
  if won?(board) == nil
    puts "Cat's Game!"
  end
end
