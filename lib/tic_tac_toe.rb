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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
  return index
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if(index.between?(0, 8) && !position_taken?(board, index))
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  
  token = current_player(board)
  
  if(valid_move?(board, index))
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if (space == " " || space == "" || space == nil)
      nil
    else
      count += 1
    end
  end
  
  return count
end

def current_player(board)
  count = turn_count(board)
  if( count.even? )
    return "X"
  else
    return "O"
  end
end

def won?(board)
  if( board.all?{|i| i == " "} )
    false
  else
    WIN_COMBINATIONS.each do |combo|
      if( (board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") ||
          (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O") )
        return combo
      end
    end
    false
  end
end

def full?(board)
  board.all?{|i| i == "X" || i == "O" }
end

def draw?(board)
  if( full?(board) == true && won?(board) == false )
    return true
  else
    false
  end
end

def over?(board)
  if(draw?(board) == true || (won?(board)))
    return true
  else
    false
  end
end

def winner(board)
  if(draw?(board) == over?(board))
    nil
  else
    index = won?(board)
    if(board[index[0]] == "X" && board[index[1]] == "X" && board[index[2]] == "X")
      return "X"
    elsif(board[index[0]] == "O" && board[index[1]] == "O" && board[index[2]] == "O")
      return "O"
    end
  end
end

def play(board)
  until (over?(board))
    turn(board)
  end
  
  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  elsif(draw?(board))
    puts "Cat's Game!"
  end
end