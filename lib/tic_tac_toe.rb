require "pry"
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
  ]
  
  def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

 #board = [" "," "," "," "," "," "," "," "," "]

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
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
  count = 0
  board.each do |entry|
    if entry != " "
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"  
  else
    return "O"
  end
end 

def won?(board)
    WIN_COMBINATIONS.find do |winning_combo|
    win_index_1 = winning_combo[0]
    win_index_2 = winning_combo[1]
    win_index_3 = winning_combo[2]
     
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
     
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
       winning_combo
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
       winning_combo
     end
    end
  end
  
  def full?(board) 
    board.all? do |full|
      if full == " "
        false
      else
        true
      end
    end
  end
  
  def draw?(board)
    if !won?(board) && full?(board)
      return true
    else
      return false
    end
  end
  
  def over?(board)
    if won?(board) || draw?(board)
      return true
    end
  end

  def winner(board) 
    if   won?(board)
      return board[won?(board)[0]]
    else
      return nil
    end
  end
    
    def play(board)
      #binding.pry
      until over?(board) do 
        turn(board)
      end
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif draw?(board)
        puts "Cat's Game!"
      end
    end
  
                                                 