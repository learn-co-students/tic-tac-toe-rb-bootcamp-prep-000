
WIN_COMBINATIONS =
 [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

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

 def move(board, position, char)
   board[position] = char
 end

 def position_taken? (board, index)
   if board[index] == " " || board[index] == "" || !board[index]
     false
   else
     true
   end
 end

 def valid_move? (board, index)
   if !position_taken?(board, index) && index.between?(0, 8)
     true
   end
 end

 def turn(board)
   display_board(board)
   puts "Please enter 1-9:"
   user_input = gets.chomp
   index = input_to_index(user_input)
   if valid_move?(board, index)
     char = current_player(board)
     move(board, index, char)
     display_board(board)
   else
     puts "Enter a valid move"
     turn(board)
   end
 end

 def turn_count(board)
   board.select { |pos| pos != ' ' }.count
 end

 def current_player(board)
   turn_count(board).odd? ? "O" : "X"
 end

 def won?(board)
   WIN_COMBINATIONS.each do |combo|
     win_index_1 = combo[0]
     win_index_2 = combo[1]
     win_index_3 = combo[2]
     potential_win = [board[win_index_1], board[win_index_2], board[win_index_3]]
     if potential_win.all? { |el| el == "X" } || potential_win.all? { |el| el == "O" }
       return combo
     end
   end
   false
 end

 def full?(board)
   board.all? { |pos| pos != " " }
 end

 def draw?(board)
   f = full?(board)
   w = !won?(board)
   w && f
 end

 def over?(board)
   won?(board) || draw?(board)
 end

 def winner(board)
  #  !won?(board) ? nil : board[won?(board)[0]]
   if !won?(board)
     nil
   else
     board[won?(board)[0]]
   end
 end

 def play(board)
   if won?(board)
     puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
     puts "Cats Game!"
   else
     until over?(board)
       turn(board)
       play(board)
     end
   end
end
