WIN_COMBINATIONS = [
  [0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[6,4,2],
]
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(num)
  return   (num.to_i)-1
end

def move(board,idx,x)
  board[idx]= x
  display_board(board)
end

def position_taken?(board, index)
 return true   if  !(board[index].nil? || board[index] == " ")
 return false
end

def valid_move?(board,index)
return true if !(position_taken?(board,index)) && (0..9).include?(index)
return false
end

def turn(board)
  puts "select position on board between 1-9 "
  num = gets.chomp
  index = input_to_index(num)
  if valid_move?(board,index)
    move(board,index,current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each { |char| count +=1 unless char == " "}
  return count
end

def current_player(board)
  return "X" if turn_count(board).even?
  return "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |arr|
   if  arr.all?  {|ele|  board[ele] == "X"}

     return arr
   elsif arr.all?  {|ele|   board[ele] == "O"}

     return arr
   else

   end
  end
    false
end

def full?(board)
  count=0
  board.each {|str| count += 1 unless str == " " }
  return true if count == board.length
  false
end


def draw?(board)
  x = won?(board)
  y = full?(board)
  if x == false && y  ==  true
    return true
  elsif (x == false && y == false) || x != false
    return false
  end
end

def over?(board)
  return true if (won?(board) || draw?(board) || full?(board))
end

def winner(board)
  return board[won?(board)[0]] if won?(board)
  return nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) != false
    return puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
     return puts "Cats Game!"
   end
end
