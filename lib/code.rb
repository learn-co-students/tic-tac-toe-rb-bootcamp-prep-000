# turn from hard
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, sign)
  else
    turn(board)
  end
end

#turn from my Code
def turn(board)
  puts "Please enter 1-9:"
  user_number = gets.strip
  index = input_to_index(user_number)
  if !(valid_move?(board,index)) 
    puts "Not a valid move. Try again."
    turn(board)
  else
    move(board, index, sign)
  end
end
