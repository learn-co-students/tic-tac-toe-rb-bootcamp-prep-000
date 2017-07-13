WIN_COMBINATIONS =[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def display_board(board) #Define a method display_board that prints a 3x3 Tic Tac Toe Board
  puts" #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts" #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(str)
str.to_i - 1
end

def move(board, index, ch)
board[index] = ch
end

def position_taken?(board, index)#
if board[index] == " " || board[index] == "" || board[index] == nil
  return false
else
  return true
end
end

def valid_move?(board, index)
index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input  =  gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
        move(board,index, current_player(board))
       display_board(board)
  else
      turn(board)
  end
end

def turn_count(board)
board.count {|el| el == "X" || el == "O"}
end

def current_player(board)
turn_count(board).even? ? "X":"O"
end

def won?(board)
WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3]

  if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
    return win_combination
  end
  #if position_1 == "X" && position_2 == "X" && position_3 == "X"
  #  return win_combination
  #elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
  #  return win_combination
  #end
end
false
end

def full?(board)
count = 0
  board.each do |el|
    if el == "X" || el == "O"
      count+=1
    end
  end
  if count == 9
    return true
  else
    return false
  end
end

def draw?(board)
!won?(board) && full?(board)
end

def over?(board)
  return true if (won?(board) || draw?(board) || full?(board))
end
def winner(board)
  #binding.pry
  if won?(board)
    board[won?(board)[1]]
  else
  #elsif draw?(board) && full?(board)
     return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
