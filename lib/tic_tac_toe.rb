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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def  turn_count(board)
  counter = 0
  turns = 0
    while counter < board.length

     if board[counter] != " "
        turns +=1
      end
      counter +=1
    end

return turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end

end
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  counter = 0
  while counter < 8
    a = WIN_COMBINATIONS[counter][0]
    b = WIN_COMBINATIONS[counter][1]
    c = WIN_COMBINATIONS[counter][2]
    if board[a] == "X" &&  board[b] == "X" &&  board[c] == "X" || board[a] == "O" &&  board[b] == "O" &&  board[c] == "O"
      return WIN_COMBINATIONS[counter]
      break
      break

    end

    counter += 1
  end
return false
end


def full?(board)
  bol = true
  x = 0
  while x < 9
    if board[x] == " "
      bol = false
      return bol
      break
    end
    x+=1
  end
  return bol
  end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  elsif full?(board) == false && won?(board) == false
    return false
  elsif  won?(board) == true
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return true
  end
end

def winner(board)
  if won?(board) != false
   a = won?(board)
   b = a[0]
   if board[b] == "X"
     return "X"
   else
     return "O"
   end
  else
    return nil

  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end



end
