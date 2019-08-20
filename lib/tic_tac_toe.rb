WIN_COMBINATIONS = [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]


def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} "
puts "-----------"
puts " #{board[3]} | #{board[4]} | #{board[5]} "
puts "-----------"
puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
return -1 if input == nil
input.to_i - 1
end

def move(board,idx,player)
board[idx] = player
end

def position_taken?(board, position)
return true if board[position] == "X" || board[position] == "O"
return false if board[position] == " "
end

def valid_move?(board, position)
return false if position < 0 
if board[position] == " "
  return true 
end
return false
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  token = current_player(board)
  if valid_move?(board,index)
    puts 'valid move'
    move(board, index, token)
    display_board(board)
   else
    puts 'try again'
    turn(board)
  end
  display_board(board)
end


=begin
def turn(board)
puts "Enter your possition between 1-9."
input = gets.chomp.to_i 
idx = input_to_index(input)
if valid_move?(board,idx)
puts board[input] = "X" || board[input] = "O"
else 
  puts "Enter your possition between 1-9."
  input = gets.chomp
end
end 
=end
def turn_count(board)
  board.count { |chr| chr =="X" || chr == "O"}
end

def current_player(board)
if turn_count(board)%2 ==0
    current_player = "X"
  else
    current_player = "O"
end
return current_player
end

def won?(board)
  WIN_COMBINATIONS.each do |subarr|
    if board[subarr[0]] == board[subarr[1]] && board[subarr[1]] == board[subarr[2]] && board[subarr[0]] != " "
    return  subarr
    end
  end
  return false
end

def full?(board)
board.none? {|ele| ele == " " }
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

=begin
def draw?(board)
 if !won?(board) && full?(board)
     return true
   elsif !won?(board) && !full?(board)
     return false
   else won?(board)
     return false
   end
end
=end

def over?(board)
   if draw?(board) || won?(board) || full?(board)
     return true
   end
end


def winner(board)
 if won?(board)
   board[won?(board)[0]]
 end
end


def play(board)
   until over?(board) 
      turn(board)
   end 
   if won?(board)
      winner(board) == "X" || winner(board) == "O" 
      puts "Congratulations #{winner(board)}!" 
   elsif draw?(board)
      puts "Cat's Game!" 
   end 
end















