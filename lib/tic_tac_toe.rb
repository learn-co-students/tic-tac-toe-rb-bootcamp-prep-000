
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
 
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [6, 4, 2],
  [0, 4, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
  ]

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
  choice = input_to_index(gets.strip())
  if valid_move?(board, choice)
    move(board, choice, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  occupied_spaces = 0 
  board.each do |space|
    if (space != "" && space != " ")
      occupied_spaces +=1
    end
  end
  return occupied_spaces
end

def current_player(board)
  return "X" if turn_count(board) % 2 == 0
  return "O"
end

 def won?(board) #return false if there are no winning combinations
    WIN_COMBINATIONS.each {|combination| 
      return combination if 
        (combination.all? {|position| board[position] == "X"}) || 
        (combination.all? {|position| board[position] == "O"})}
    return false
  end

  def full?(board)
    board.all? {|position| position == "X" || position == "O"}
  end

def draw?(board) #returns true if the board has not been won but is full
    return true if won?(board) == false && full?(board)
  end
  
  def over?(board)
    return true if draw?(board) || won?(board) != false
  end
  
  def winner(board)
    return board[won?(board)[0]] if won?(board) != false
  end

def play(board)
  until over?(board) do
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

