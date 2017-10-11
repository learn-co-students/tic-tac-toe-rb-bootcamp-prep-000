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

def move(board, index, current_player = "X")
  board[index] = current_player
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip.to_i-1
  input_to_index(input)
if valid_move?(board, input)
    move(board, input, character = "X")
 end
   display_board(board)

end

def play(board)
num_time = 0
while num_time !=9
  turn(board)
  num_time +=1
end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS=[
  [0,1,2], #top horizontal win
  [3,4,5], #Middle horizontal win
  [6,7,8], #Bottomr horizontal win
  [0,3,6], #Left Vert win
  [1,4,7], #Middle Vert win
  [2,5,8], #Right Vert Win
  [0,4,8], #Diagonal win
  [2,4,6] #Diagonal win
]

  def won?(board)
     WIN_COMBINATIONS.detect do |combo|
       board[combo[0]] == board[combo[1]] &&
       board[combo[1]] == board[combo[2]] &&
       position_taken?(board, combo[0])
     end
   end

def full?(board)
  !board.any? { |x| x == " " }
end

def draw?(board)

   if (full?(board) && !won?(board))
      true
   else
      false
   end
 end

 def turn_count(board)
   turn = 0
    board.each do |unit|
      if unit == "X" || unit == "O"
 turn +=1
 end
 end
 return turn
 end


 def current_player(board)
   if turn_count(board) % 2 == 0
     return "X"
   else
     return "O"
   end
 end

 def over?(board)
    won?(board) || draw?(board) || full?(board)
  end

def winner(board)
   WIN_COMBINATIONS.each do |win_combination|
  if board [win_combination[0]] == "X" && board [win_combination[1]] == "X" && board [win_combination[2]] == "X"
   return "X"
  elsif board [win_combination[0]] == "O" && board [win_combination[1]] == "O" && board [win_combination[2]] == "O"
  return "O"
  else
   end
  end
  nil
 end
