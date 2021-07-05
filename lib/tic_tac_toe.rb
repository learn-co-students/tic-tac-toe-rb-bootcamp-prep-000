
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(number)
 input = number.to_i
return input - 1
end

def move(array, index, charachter)
array[index] = charachter
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
  space = valid_move?(board, index)
  if space == true
    charachter = current_player(board)
    move(board, index, charachter)
  else 
    turn(board)
  end
  display_board(board)
end


def turn_count(board)
count = 0
 board.each do |space|
  if space != " "
   count += 1
 end
end
return count
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board) 
 win_combo(board).first
end

def win_combo(board)
  WIN_COMBINATIONS.select do |winner|
    (board[winner[0]] =="X" && board[winner[1]] == "X" && board[winner[2]] == "X") || (board[winner[0]] =="O" && board[winner[1]] == "O" && board[winner[2]] == "O")
  end
end

def full?(board)
board.none? {|i|
i == " "
}
end

def draw?(board)
full?(board) && !won?(board)
end

def over?(board)
 full?(board) || won?(board) || draw?(board)
end

def winner(board)
winning_board = won?(board)
if winning_board == nil
  return nil
end

winning_char = board[win_combo(board)[0][0]]
if winning_board != nil 
  return winning_char
end
end




def play(board)
  until over?(board)
  turn(board)
  end
  if over?(board)
  if won?(board)
  player = winner(board)
  puts "Congratulations #{player}!"
  elsif draw?(board) == true
  puts "Cat's Game!"
end
end
end









