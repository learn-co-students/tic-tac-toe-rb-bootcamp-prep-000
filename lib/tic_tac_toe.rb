

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

def move(board, index, token)

  board[index] = token
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

    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
   puts "That is an invalid move. Try again."
   puts "Please enter 1-9:"
   input = gets.strip
   index = input_to_index(input)
   if valid_move?(board, index)

     token = current_player(board)
     move(board, index, token)
     display_board(board)
   end
  end

end

def play(board)

  if (over?(board))
    if (won?(board))
      puts "Congratulations #{winner(board)}!"
      return nil
    end
    puts "Cat's Game!"
    return nil
  end
  counter = 0
  while (counter <9)

    turn(board)
    counter +=1

    if (over?(board))
      if (won?(board))
        puts "Congratulations #{winner(board)}!"
        return true
      end
      puts "Cat's Game"
      return false
    end
  end

end


def turn_count(board)
  counter = 0
board.each do |space|

    if (space != ' ')
    counter += 1
    else
    end
  end
  return counter
end

def current_player(board)
token=['X','O']
turn_number = turn_count(board)+1
token_number = turn_number/2-(turn_number-1)/2
return token[token_number]
end


def won?(board)
  if board.none?{|i| i=='X'} && board.none?{|i| i=='O'}
    return false
  elsif WIN_COMBINATIONS.each do |potential_winner|
              win_index1=potential_winner[0]
              win_index2=potential_winner[1]
              win_index3=potential_winner[2]
              if board[win_index1] == 'X' && board[win_index2] == 'X' && board[win_index3] == 'X'
                return array = [win_index1,win_index2,win_index3]
              elsif board[win_index1] == 'O' && board[win_index2] == 'O' && board[win_index3] == 'O'
                return array = [win_index1,win_index2,win_index3]
              end
                        end
  elsif (full?(board)==true)
    return false


end
  return false
end



def full?(board)
  board.none? do |what|
    what == " "
  end
end




def draw?(board)
  if (won?(board) == false && full?(board)==true)
    return true
  end
end



def over?(board)
  if (won?(board) || draw?(board))
    return true
  end
  return false

end



def winner(board)
  if won?(board) == false
    return nil
  else

    WIN_COMBINATIONS.each do |potential_winner|
      win_index1=potential_winner[0]
      win_index2=potential_winner[1]
      win_index3=potential_winner[2]
      if board[win_index1] == 'X' && board[win_index2] == 'X' && board[win_index3] == 'X'
        return winner = 'X'
      elsif board[win_index1] == 'O' && board[win_index2] == 'O' && board[win_index3] == 'O'
        return winner = 'O'
      end
    end


  end
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end



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
