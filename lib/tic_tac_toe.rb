
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [2,4,6], [0,4,8], [0,3,6], [1,4,7], [2,5,8]]

def display_board(board)

  line = "-----------"
  print " #{board[0]} | #{board[1]} | #{board[2]} \n"
  puts line
  print " #{board[3]} | #{board[4]} | #{board[5]} \n"
  puts line
  print " #{board[6]} | #{board[7]} | #{board[8]} \n"

end

def input_to_index(x)
  input = (x.to_i) - 1
end

def move(board, index, character)
  board[index] = character
end


def position_taken?(board, index)
  if((board[index] == "")||(board[index] == " ")||(board[index] == nil))
    return false
  else
    return true
  end
end

def valid_move?(board, index)

  if(index.between?(0,8) == false || position_taken?(board, index) == true)
    return false
  else
    return true
  end

end





def turn_count(board)
  numberPlays = 0
  board.each do |i|
    if (i == "X" || i == "O")
      numberPlays += 1
    end
  end
  return numberPlays
end


def current_player(board)
  (turn_count(board)  == 0 || turn_count(board) % 2 == 0) ? "X" : "O"
end

def won?(board)

  i=0
  while i < 8
    if board[WIN_COMBINATIONS[i][0]] == "O" && board[WIN_COMBINATIONS[i][1]] == "O" && board[WIN_COMBINATIONS[i][2]] == "O" ||
        board[WIN_COMBINATIONS[i][0]] == "X" && board[WIN_COMBINATIONS[i][1]] == "X" && board[WIN_COMBINATIONS[i][2]] == "X"
      #print WIN_COMBINATIONS[i]
      return WIN_COMBINATIONS[i]
    end
    i += 1
  end

end

def draw?(board)
  if full?(board) and !(won?(board))
    return true
  end
end

def over?(board)
  if won?(board) or draw?(board)
    return true
  end
end

def winner(board)
  if !(won?(board))
    return nil
  elsif board[won?(board)[0]] == "O"
    return  "O"
  else
    return  "X"
  end
end

def full?(board)
  board.all? { |letter| !(letter == nil || letter == " ")}
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




def play(board)
  move(board, 0, "X")
  turn(board)
 until over?(board)
   turn(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
 end
end
