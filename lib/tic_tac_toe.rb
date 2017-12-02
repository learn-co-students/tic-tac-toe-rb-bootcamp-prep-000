
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  user_input.to_i-1
end

def move(board_array, index_of_board, player_character)
   board_array[index_of_board]=player_character
end

def valid_move?(board, index)
  index.between?(0,8)&& !position_taken?(board, index)

end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
 board[index]=="X"||board[index]=="O"

end

def turn(board)

  puts "Please enter 1-9:"
  input=gets.strip
  index=input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    puts "Invalid move"
    turn(board)
  end
end


 def turn_count(board)
   counter =0
   board.each do |space|

     if space=="X"
       counter += 1
     elsif space=="O"
       counter += 1
     end
   end
   return counter
 end

 def current_player(board)
   turn_count(board).even? ? "X" : "O"
   end



   WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[6,4,2],[0,4,8]]

   def find_winning_combo (board)
   WIN_COMBINATIONS.each do |win_combination|
     win_index_1=win_combination[0]
     win_index_2=win_combination[1]
     win_index_3=win_combination[2]

     position_1=board[win_index_1]
     position_2=board[win_index_2]
     position_3=board[win_index_3]

     if position_1=="X"&& position_2=="X" && position_3=="X"
       return win_combination
     elsif position_1=="O"&& position_2=="O" && position_3=="O"
       return win_combination
     end
   end
    return false
   end

   def won?(board)
     find_winning_combo(board).class==Array
   end

   def full? (board)
     board.all? do |spaces|
       spaces=="X"||spaces=="O"
     end
   end

   def draw? (board)
     if full?(board) && !won?(board)
       return true
     else
       return false
     end
   end

   def over?(board)
     if won?(board)||draw?(board)||full?(board)
       return true
     else
       return false
     end
   end

   def winner(board)
     if won?(board)
       return board [find_winning_combo(board)[0]]
     end
   end

   def play (board)

      while !over?(board)
      turn(board)
    end
  # require "pry"
  #   binding.pry
       if won?(board)
         puts "Congratulations #{winner(board)}!"
       elsif draw?(board)
         puts "Cat's Game!"
       end

       end
