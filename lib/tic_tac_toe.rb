
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



def current_player(board)
  turn_count(board).even? ? "X":"O"

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
  else turn(board)
  end
end

def turn_count(board)
  no_x=board.select do |x|
  x=="X"
end
  no_o=board.select do |o|
  o=="O"
end

  turn=no_x.count+no_o.count

end

def full?(board)
  board.all? do |board_position|
 !(board_position.nil? || board_position == " " || board_position =="")
end
end


def won?(board)
  store=WIN_COMBINATIONS.select do |combination|
    board[combination[0]]=="X" && board[combination[1]]=="X"&& board[combination[2]]=="X" || board[combination[0]]=="O" && board[combination[1]]=="O"&& board[combination[2]]=="O"
  end
  store=store[0]
  if store==[] || store== nil
    false
  else  true
  end

end

def draw?(board)
  if won?(board)==true  #the game is won
    false
  # the game is not won
  elsif full?(board)==true  #the board is full
    true
  else                    #the board is not full
    false
  end
end


def over?(board)
  if won?(board)
  true
elsif draw?(board)
  true
  end
end

def winner(board)

  no_x=board.select do |x|
  x=="X"
  end

  no_o=board.select do |o|
  o=="O"
  end

  if won?(board)==false
    nil
  elsif no_x.count > no_o.count
  "X"
  else
  "O"
  end


end

def over?(board)
  if won?(board)
  true
elsif draw?(board)
  true
  end
end




def play(board)
  until over?(board)==true
  display_board(board)
  turn(board)
  end

  if won?(board)

    no_x=board.select do |x|
    x=="X"
    end
    no_o=board.select do |o|
    o=="O"
    end

    if no_x.count>no_o.count
    winner="X"
    else winner="O"
    end
    puts "Congratulations #{winner}!"


  elsif draw?(board)
    puts "Cats Game!"
  else false
  end
end
