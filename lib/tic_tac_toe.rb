WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], 
  [0,3,6], 
  [1,4,7], 
  [2,5,8], 
  [6,4,2], 
  [0,4,8] 
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input) input.to_i - 1  end
  
def move(board,index,mark) board[index] = mark end
  
def position_taken?(board,position) board[position] != " " end

def valid_move?(board,index) index >= 0 && index <= 8 && board[index] == " " end
  
def turn_count(board) board.reject{ |b| b == " " }.length end

def current_player(board) turn_count(board) % 2 == 0 ? "X" : "O" end
  
def won?(board)
  WIN_COMBINATIONS.any? do |win|
    if win.all? do |pos| board[pos] == "X" end || win.all? do |pos| board[pos] == "O" end
      return win
    end
  end
end

def full?(board) board.each_index.all?{|p| position_taken?(board,p)} end
  
def draw?(board) !won?(board) && full?(board) end
  
def over?(board) won?(board) || draw?(board) end
  
def winner(board) 
  if won?(board) != false 
    board[won?(board).first]
  end
end
  
def turn(board)
  display_board(board)
  puts "Please enter 1–9."
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
  else turn(board)
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    display_board(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end