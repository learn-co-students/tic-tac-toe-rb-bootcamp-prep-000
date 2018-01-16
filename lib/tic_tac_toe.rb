WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

board = [" "," "," "," "," "," "," "," "," "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
  num = num.to_i
  index = num - 1
end

def move(board,index,character)
  board[index] = character
  return board
end

def position_taken?(board,index)
  if board.length == 0
    return
  elsif (board[index] == " ") || (board[index] == "") || (board[index] == nil)
    return false
  else
    return true
  end
end

def valid_move?(board,index)
  if index.between?(0,8)
    if position_taken?(board,index)
      return false
    else 
      return true
    end
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  realindex = input_to_index(input)
  if valid_move?(board,realindex)
    move(board,realindex,current_player(board))
    display_board(board)
    #return turn(board)
  else
    return turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each{|loc| 
    if (loc == "X") || (loc == "O")
      counter +=1
    end
  }
  return counter
end

def current_player(board)
  if turn_count(board).odd?
    return "O"
  else
    return "X"
  end
end

def won?(board)
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  else
    WIN_COMBINATIONS.any?{|combo|
      if position_taken?(board, combo[0])
        if board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
          return combo
        end
      end
      }
  end
end

def full?(board)
  i = 0
  while i < board.length 
    if position_taken?(board,i) == false
      return false
      break
    else
      i += 1
    end
  end
  return true
end

def draw?(board)
  if full?(board) == true && won?(board) == false 
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  elsif !(full?(board))
    return false
  end
end

def winner(board)
  if draw?(board) || over?(board) == false
    return nil
  else
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) == true do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end