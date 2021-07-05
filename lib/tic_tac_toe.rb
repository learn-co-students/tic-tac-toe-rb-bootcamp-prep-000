WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
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

def turn_count(board)
  count=0
  board.each do |space|
    if(space=="X"||space=="O")
      count+=1
end
end
return count

end

def current_player(board)
  number=turn_count(board)

    if(number%2==0)
      return "X"
    else
      return "O"
    
  end
end

def won?(board)
  WIN_COMBINATIONS.each { |win_comb|
    if(board[win_comb[0]]=="X" && board[win_comb[1]]=="X" && board[win_comb[2]]=="X")
      return win_comb
      elsif(board[win_comb[0]]=="O" && board[win_comb[1]]=="O" && board[win_comb[2]]=="O")
      return win_comb
    end
  } 
      return false
  
end

def full?(board)
  board.all? {|position|
  position=="X" || position=="O"
  }
end

def draw?(board)
  if(full?(board)&&!won?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if(won?(board)||draw?(board)||full?(board))
    return true
  else
    return false
  end
  
end

def winner(board)
  if(won?(board)==false)
    return nil
  elsif(board[won?(board)[0]]=="X")
    return "X"
    else(board[won?(board)[0]]=="O")
    return "O"
 
  end
end




def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end