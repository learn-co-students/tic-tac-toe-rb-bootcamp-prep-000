WIN_COMBINATIONS = [
  [0, 1, 2],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
  [3, 4, 5],
  [6, 7, 8]
  ]
  
  
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
  
def input_to_index(user_input)
  user_input = user_input.to_i
  user_input -= 1
end

def move(board, index, current_player)
  board[index] = current_player
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

  
def valid_move?(board, index)
  
  def valid_position?(number)
    if number.between?(0, 8)
      return true
    else
      return false
    end
  end

  if (position_taken?(board, index)) == false && (valid_position?(index)) == true
    return true
  else
    return false
  end
end

def turn_count(board)
  turn_number = 0
  board.each do |position|
    if position == "X" || position == "O"
      turn_number += 1
    end
  end
  return turn_number
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "PLease enter 1-9:"
  num = gets.strip
  index = input_to_index(num)
  
  if valid_move?(board, index) == true
      character = current_player(board)
      move(board, index, character)
      display_board(board)
  else
    turn(board)
  end
end


def won?(board)
  WIN_COMBINATIONS.each {|win_combination|
    index_0 = win_combination[0]
    index_1 = win_combination[1]
    index_2 = win_combination[2]
    
    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif
      position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end}
    return false
  end
  
def full?(board)
  if board.all? {|index| index == "X" || index == "O"}
    return true
  else
    return false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return "Draw"
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else 
    return false
  end 
end

def winner(board)
  index = []
  index = won?(board)
  if index == false
    return nil
  elsif board[index[0]] == "X"
      return "X"
  else
      return "O"
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



    


  


