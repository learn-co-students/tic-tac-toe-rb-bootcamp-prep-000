#play methods

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

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, "X")
    display_board(board)
  else
    turn(board)
  end
end

def turnO(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, "O")
    display_board(board)
  else
    turn(board)
  end
end

def computer_turn(board)
  cmove = rand(9)
  if valid_move?(board, cmove)
    move(board, cmove, "O")
    display_board(board)
  else
    computer_turn(board)
  end
end

def rannum
  rand(9)
end

# Define your play method below

def play(board)
  count = 1 
  until count == 10
  if over?(board)
    handle_over(board)
    break
  else 
   if count % 2 == 0 
     turnO(board)
     #   computer_turn(board)
     else 
        turn(board)
    end
end
  count +=1 
end
end

#Game Status

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


 WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    windex_1 = combo[0]
    windex_2 = combo[1]
    windex_3 = combo[2]
    pos1 = board[windex_1]
    pos2 = board[windex_2]
    pos3 = board[windex_3]
    if (pos1 == "X" && pos2 == "X" && pos3 == "X") || (pos1 == "O" && pos2 == "O" && pos3 == "O")
      return combo
  end
end
return false
end

def full?(board)
  board.none? do |pos|
    pos == " "
  end
end

def draw?(board)
  if full?(board) && !won?(board)
      return true
end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board) == false
    return nil
  end
return board[won?(board)[0]]
end

#useful?

def turn_count(board)
  counter = 0 
  board.each do |board_b|
    if board_b == "O" || board_b == "X"
      counter += 1 
    end
  end
      return counter

end

def current_player(board)
  total_turns = turn_count(board)
  if total_turns % 2 == 0 
   return "X"
  else
    return "O" 
  end
end

def handle_over(board)
  if draw?(board) == true
    puts "Cat's Game!"
  else
    the_winner = winner(board)
    puts "Congratulations #{the_winner}!"
end
end