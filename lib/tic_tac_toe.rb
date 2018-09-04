
# Define your WIN_COMBINATIONS constant
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
  turn_number = 0
  board.each do |space|
    if space == "X" || space == "O"
      turn_number += 1
    end
  end
  return turn_number
end

def current_player(board)
  number_of_turns = turn_count(board)
  number_of_turns = number_of_turns % 2
  if number_of_turns == 0
    return "X"
  else
    return "O"
  end
end

 def won?(board)
    returnBool = false
    WIN_COMBINATIONS.each do |combo|
      pos1 = board[combo[0]]
      pos2 = board[combo[1]]
      pos3 = board[combo[2]]
      if pos1 == pos2 && pos2 == pos3 && pos3 == pos1
        if pos1 == "X" || pos1 == "O"
          return combo
        end
      end
    end
    return false
  end
  

  
   def full?(board)
    if board.detect {|i| i == " " || i == nil}
    return false
   else
    return true
   end
   end
   
   def draw?(board)
     if full?(board) && !won?(board)
       return true
     else
       return false
     end
   end
   
   def over?(board)
     if won?(board) || draw?(board) ||full?(board)
       return true
     else
       return false
     end
   end
   
   def winner(board)
    if winnerCombo = won?(board)
     return board[winnerCombo[0]]
    end
   end
   
   def play(board)
     until over?(board)
      turn(board)
     end
     
     if draw?(board)
       puts "Cat's Game!"
     else
       puts "Congratulations #{winner(board)}!"
     end
   end