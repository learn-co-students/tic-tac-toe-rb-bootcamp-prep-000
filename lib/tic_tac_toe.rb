WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = "-----------"
  row3 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row4 = "-----------"
  row5 = " #{board[6]} | #{board[7]} | #{board[8]} "
  puts row1
  puts row2
  puts row3
  puts row4
  puts row5
 end

 def input_to_index(input)
   input.to_i - 1
 end

 def move(array, index, value)
   array[index] = value
 end

 def position_taken?(board, index)
   if board[index] == " "
     false
   elsif board[index] == ""
     false
   elsif board[index] == nil
     false
   elsif board[index] == "X" || board[index] == "O"
     true
   end
 end

 def valid_move?(board, index)
   if board[index] == " " && index.between?(0,8)
     return true
   end
 end

 def turn(board)
   puts "Please enter 1-9:"
   input = gets.strip
   index = input_to_index(input)
   value = current_player(board)
   if valid_move?(board, index)
     move(board, index, value)
   else
     puts "Try again please"
     turn(board)
   end
   display_board(board)
 end

 def turn_count(board)
   counter = 0
   board.each do |turn|
     if turn == "X"
       counter += 1
     elsif turn == "O"
       counter += 1
     end
   end
 return counter
 end

 def current_player(board)
   count = turn_count(board)
     if count % 2 == 0
       return "X"
     else
       return "O"
     end
 end

 def won?(board)
   WIN_COMBINATIONS.each do |win_combination|
     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
     win_index_3 = win_combination[2]

     position_1 = board[win_index_1]
     position_2 = board[win_index_2]
     position_3 = board[win_index_3]

     if position_1 == "X" && position_2 == "X" && position_3 == "X"
       return win_combination
     end
     if position_1 == "O" && position_2 == "O" && position_3 == "O"
       return win_combination
     end
   end
   return nil
 end

 def full?(board)
   index = 0
   items_in_board = board.size
   while index < items_in_board
     if board[index] == "" || board[index] == " "
       return false
     end
     index += 1
   end
   return true
 end

 def draw?(board)
   if !won?(board) && !full?(board)
     return false
   end
   if !won?(board) && full?(board)
     return true
   end
   if !won?(board)
     return false
   end
 end

 def over?(board)
   if full?(board) || draw?(board) || won?(board)
     return true
   else
     return false
   end
 end

 def winner(board)
   if won?(board) == nil
     return nil
   end
   win_combo = won?(board) #get winning array
   index = win_combo[0]
   if board[index] == "X"
     return "X"
   elsif board[index] == "O"
     return "O"
   end
 end

 def play(board)
   while over?(board) != true do
     turn(board)
   end
   if won?(board)
     winner = winner(board)
     if winner == "X"
       puts "Congratulations X!"
     elsif winner == "O"
       puts "Congratulations O!"
     end
   end
   if draw?(board)
     puts "Cats Game!"
   end
 end
