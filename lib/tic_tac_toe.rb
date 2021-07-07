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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, position)
  board[position] != " " && board[position] != ""
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
  counter = 0 
  board.each{|spot| counter += 1 if spot == 'X' || spot == 'O'}
  counter 
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
   return combo if combo.all?{|x| board[x] == 'X'} || combo.all?{|x| board[x] == 'O'}
 end
 false
end

def full?(board)
  board.all?{|char| char == 'X' || char == 'O'}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  WIN_COMBINATIONS.each{|combo| return 'X' if combo.all?{|x| board[x] == 'X'}} 
  return nil if !won?(board)
  'O'
end

def play(board)
  until over?(board)
    turn(board)
  end
  puts "Congratulations #{winner(board)}!" if won?(board)
  puts "Cat's Game!" if draw?(board)
end

