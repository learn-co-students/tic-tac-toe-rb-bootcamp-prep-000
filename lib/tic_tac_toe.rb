def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(array,position,char)
  array[position] = char
end

# def position_taken?(board,index)
#   if board[index] == "" || board[index] == " " || board[index] == nil
#     false
#   elsif board[index] == "X" || board[index] == "O"
#     true
#   end
# end

def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end



def turn_count(board)
  counter = 0
  board.each do |place|
    if place != " "
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  current_turn = turn_count(board).to_i
  if current_turn %2 == 0
    return "X"
  elsif current_turn %2 != 0
    return "O"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
[0,1,2], #top row win
[3,4,5], #middle row win
[6,7,8], #bottom row win
[0,3,6], #leftmost win
[1,4,7], #middle win
[2,5,8], #rightmost win
[0,4,8], #left-to-right win
[2,4,6]  #right-to-left win
]

def won?(board)
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  end

  WIN_COMBINATIONS.detect do |i|
    index_1 = i[0]
    index_2 = i[1]
    index_3 = i[2]
    if board[index_1] == "X" && board[index_2] == "X" && board[index_3] == "X" ||
       board[index_1] == "O" && board[index_2] == "O" && board[index_3] == "O"
          true
    else
          false
        end
    end
end

def full?(board)
  board.none? do |index|
    index == " "
  end
end

def draw?(board)
  if won?(board) == nil && full?(board) == true
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board) || full?(board)
      true
  else
      false
  end
end

def winner(board)
  if won?(board) == nil
    return nil
  end
  index_check = won?(board)[0]
  board_check = board[index_check]
  if board_check == "X"
    return "X"
  elsif board_check == "O"
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
      turn(board)
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
      if draw?(board)
        puts "Cats Game!"
          end
      if winner(board) == "X"
        puts "Congratulations X!"
      elsif winner(board) == "O"
        puts "Congratulations O!"
      end

end
