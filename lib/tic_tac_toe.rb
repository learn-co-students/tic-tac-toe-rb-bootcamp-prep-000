WIN_COMBINATIONS = [
     [0, 1, 2],  #top row
     [3, 4, 5],  #mid row
     [6, 7, 8],  #bottom row
     [0, 3, 6],  #left column
     [1, 4, 7],  #center column
     [2, 5, 8],  #right column
     [0, 4, 8],  #diagonal top left to bottom right
     [2, 4, 6]   #diagonal bottom left to top right
 ]

 def display_board(board = [" "," "," "," "," "," "," "," "," "])
 row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
 row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
 row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
 seperator = "-----------"
 puts row1
 puts seperator
 puts row2
 puts seperator
 puts row3
 end

 def input_to_index(user_input)
     return user_input.to_i - 1
 end

 def move(board, index, character)
     board[index] = character
     return board
 end

 def position_taken?(board, index)
   !(board[index].nil? || board[index] == " ")
 end

 def valid_move?(board, index)
     if index > 8 || index < 0 || board[index] == "X" || board[index] == "O"
         return false
     else index <= 8 && board[index] != "X" && board[index] != "O"
         return true
     end
 end

 def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
 end

 def turn_count(board)
     counter = 0
     board.each do |value|
         if value == "X" || value == "O"
             counter += 1
         end
     end
     return counter
 end

 def current_player(board)
     turn_count(board) % 2 == 0 ? "X" : "O"
 end


 def won?(board)
     WIN_COMBINATIONS.detect do |win_combo|
         board[win_combo[0]] == board[win_combo[1]] &&
         board[win_combo[1]] == board[win_combo[2]] &&
         position_taken?(board, win_combo[0])
     end
 end

 def full?(board)
     board.all?{ |i| i == "X" || i == "O" }
 end

 def draw?(board)
     !won?(board) && full?(board)
 end

 def over?(board)
     draw?(board) || won?(board) || full?(board)
 end

 def winner(board)
     if win_combination = won?(board)
         board[win_combination[0]]
     end
 end

 def play(board)
     while !over?(board)
         turn(board)
     end
     if won?(board)
         puts "Congratulations #{winner(board)}!"
     elsif draw?(board)
         puts "Cats Game!"
     end
 end
