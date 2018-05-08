def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],  #horizontal
  [0,3,6],[1,4,7],[2,5,8],  #vertical
  [0,4,8],[2,4,6]           #diagonal
]

def input_to_index(input)
  return input.to_i - 1
end

def move(board, pos, player)
  board[pos] = player
  display_board(board)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !index.between?(0,8) || position_taken?(board, index) ? false : true
end

def turn(board)
  request_num = "Please enter 1-9:"
  puts request_num
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
  	space.include?("X")||space.include?("O") ? count += 1 : count 
  end
  return count
end #end turn_count

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def play(board)
  until over?(board) #until over? returns true, keep taking turns
    turn(board)
  end

  if won?(board) #if over, check for a winner
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination| #for each combination
    win_index_1 = combination[0]
    win_index_2 = combination[1] 
    win_index_3 = combination[2] 
    pos_1 = board[win_index_1]
    pos_2 = board[win_index_2]
    pos_3 = board[win_index_3]
    
    #if all of the "win" spaces of board are X or O
    if (pos_1 == "X" && pos_2 == "X" && pos_3 == "X") || (pos_1 == "O" && pos_2 == "O" && pos_3 == "O")
      return combination #return the entire array that won
    end #end if
  end #end iteration of WIN_COMBINATIONS
  
  return false #if no combination was returned that means there was no winner so return false.
end #end won?

def full?(board) 
  board.any?{|space| space == " " || space == nil} ? false : true 
end

def draw?(board)
  if !won?(board) && full?(board) #if no winner & board is full
    return true
  elsif won?(board) #else if a winner
    return false
  end
end


def over?(board)
  if draw?(board) || won?(board) || full?(board) #if there is a draw, win, or full board
    return true
  else
    return false
  end
end

def winner(board)
  combination = won?(board) #if there is a winner it will return the combination
  if !over?(board) #if there is no draw or no winner the game is not over yet
    return nil 
  elsif board[combination[0]] == "X" 
    return "X"
  elsif board[combination[0]] == "O" 
    return "O"
  end
end

