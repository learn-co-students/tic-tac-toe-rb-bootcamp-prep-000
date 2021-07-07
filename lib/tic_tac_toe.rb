# display_board(board)
# input_to_index(arg)
# move(board, index, player_char="X")
# valid_move?(board, index)
# position_taken?(board, index)
# turn(board)
# play(board)
# turn_count (board) 
# current_player (board)
# position_taken?(board, index)
# WIN_COMBINATIONS
# won?(board)
# full?(board)
# draw?(board)
# over?(board)
# winner(board)

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end


WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]]
 
  def input_to_index(arg)
    arg = arg.to_i
    arg = arg - 1
  end
  
  def move(board, index, player_char)
    board[index] = player_char
  end 
  

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

 
def valid_move?(board, index)
  if (index.between?(0,8)) && (!position_taken?(board,index))
    return true
  else 
    return false 
  end 
end 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, "#{current_player (board)}")
    display_board(board)
  else
    turn(board)
  end
end

def turn_count (board) 
  occupied = 0 # count occupied in board
      board.each do |element|
          if element=="X" || element=="O"
            occupied += 1 
          end 
      end
  return occupied
end 

def current_player (board)
  next_payer = turn_count(board)
  if next_payer%2 != 0 
    "O"
  else 
    "X"
  end
end 


def won?(board)
    # check win combination
      WIN_COMBINATIONS.each do |combination| 
        win_index_1 = combination[0]
        win_index_2 = combination[1]
        win_index_3 = combination[2]
        position_1 = board[win_index_1] 
        position_2 = board[win_index_2] 
        position_3 = board[win_index_3] 
        if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
          return combination 
        else 
          false
        end 
  end
  false
end


def full?(board)
      if     (board.all? do |element|
            element == " " || element == nil || element==""
            end)
        # puts "borad empty"
        return false
      elsif (board.any?{|element| element ==" " || element== nil})#=> true
        # puts "borad in progress"
        return false 
      else
        # puts "borad full"
        true
      end 
      # return true
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board) 
end

def winner(board)
  combo = won?(board)
  if combo
    return board[combo[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
   puts "Cat's Game!"
 end
    
    
end






