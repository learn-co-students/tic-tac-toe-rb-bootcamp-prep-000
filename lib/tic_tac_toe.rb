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

def input_to_index(user_input)
  input_to_integer = Integer(user_input) rescue nil
  (!input_to_integer) ? (-1) : (input_to_integer - 1)
end
def position_taken?(board, position)
  (board[position] != " ") && (board[position] != "") && (board[position] != nil)
end
def valid_move?(board, position)
  position.between?(0,8) && !position_taken?(board, position)
end
def turn_count(board)
  count = 0
  board.each { |item| (count +=1) if (item=="X" || item=="O") }
  count
end
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end
def move(board, position, player_token)
  board[position] = player_token
end
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def turn(board)                #a single complete turn
  puts "Please enter 1-9:"        #ask user for position
  position = input_to_index(gets.strip) #receive/convert input
  if valid_move?(board, position)   #validate move
    move(board, position, current_player(board))#make the move
    display_board(board)            #display board
  else
    turn(board)   # ask for a position until a valid move
  end
end

def empty?(board)
  board.all? {|e| e==nil || e==" " || e==""}
end
def won?(board)
  if empty?(board)
    false
  else
    WIN_COMBINATIONS.detect do |indexes|
      indexes.all? { |e| board[e]=="X" } ||
      indexes.all? { |e| board[e]=="O" }
    end
  end
end
def full?(board)
  board.all? {|e| e=="X" || e=="O"}
end
def draw?(board)
  full?(board) && !won?(board)
end
def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won?(board) ? (board[won?(board)[0]]) : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
