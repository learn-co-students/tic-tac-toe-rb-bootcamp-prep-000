# Helper Method

# Define display_board that accepts a board and prints
# out the current state.
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

def turn_count(board)
  turn_counter = 0
  board.each do |value|
    if value == "X" || value == "O"
turn_counter += 1
end
end
return turn_counter
end

def current_player(board)
num = turn_count(board)
if num % 2 == 0
  return "X"
else
  return "O"
end
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

def play(board)
  won?(board)
  draw?(board)
while over?(board) == false do
  turn(board)
end
if won?(board)
  puts "Congratulations #{winner(board)}!"
end
if draw?(board)
  puts "Cat's Game!"
end
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

#won method
def won?(board)

empty = 0
counter = 0
 WIN_COMBINATIONS.each do |intArr|

#set variables to board inputs
  i1 = board[intArr[0]]
  i2 = board[intArr[1]]
  i3 = board[intArr[2]]

#check to make sure mathches are not empty board spaces
#and check that board posistion match winning combinations
  if i1 != " " && i2 != " " && i3 != " " && i1 == i2 && i2 == i3 && i1 == i3
#return winning combination
return intArr
#else add 1 to counter
 else
  counter += 1
  #if counter gets to 8 return false as there are no mathches
  if counter == 8
    counter == 0
    return false
  end

 end

 puts counter

 intArr = []
 puts counter
end
end

#full method
def full?(board)
  #check if every element in the board has been filled by either an X or a O
  board.all? do |element|
 element == "X" || element == "O"
end
end

#draw method
def draw?(board)
if full?(board) && won?(board) == false
  return true
else
  return false
end
end

def over?(board)

if  won?(board) && full?(board) == false && draw?(board) == false
  return true
elsif full?(board) && won?(board)
  return true
elsif draw?(board)
  return true
else
  return false
end

end

def winner(board)
  if won?(board)
  arr = won?(board)
  sym = board[arr[0]]
return sym
else
  return nil
end
end
