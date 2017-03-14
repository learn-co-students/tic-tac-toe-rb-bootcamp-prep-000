
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each{ |win_combination|
  win_temp_var_X=0
  win_temp_var_O=0
    win_combination.each{ |win_val|
      if (board[win_val]=="X")
        win_temp_var_X+=1
      elsif (board[win_val]=="O")
        win_temp_var_O+=1
      end
    }
    return win_combination if (win_temp_var_X==3 || win_temp_var_O==3)
  }
  return nil
end

def full?(board)
  board.each{|x|
    return false if x == " "
  }
  return true
end

def draw?(board)
  return true if(!won?(board)&&full?(board))
  return false
end

def winner(board)
  return board[won?(board)[0]] if (!!(won?(board)))
  return nil if (draw?(board))  #unnecessary
end

def over?(board)
  return !!(won?(board)|| draw?(board))
end

def turn_count(board)
  count=0
  board.each { |val| count +=1 if val == "O" || val == "X"}
  return count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X":"O"
end

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

## ALTERNATIVE 
# def turn(board)
#   index=-1
#   loop do
#     puts "Please enter 1-9:"
#     input = gets.strip
#     index = input_to_index(input)
#     break if valid_move?(board,index)
#   end
#   move(board, index,current_player(board))
#   display_board(board)
# end

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

## ANOTHER WAY TO SOLVE BUT WON'T PASS RSPEC
# def play(board)
#   loop do
#     turn(board)
#     if over?(board)
#       if won?(board)
#         puts "Congratulations #{winner(board)}!"
#         break
#       end
#       if draw?(board)
#         puts "Cats Game!"
#         break
#       end
#     end
#   end
# end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
