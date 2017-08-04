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
   board.each do |input|
     if input =="X" || input == "O"
       counter +=1
     end
   end
   counter
 end

def current_player(board)
   if turn_count(board) % 2 == 0
     return "X"
   else
     return "O"
   end
end

# Define your play method below
def play(board)

 #  until the game is over
   until over?(board) do
 #    take turns
     turn(board)
   end


 #  if the game was won
   if won?(board)
 #    congratulate the winner
     puts "Congratulations #{winner(board)}!"
 #  else if the game was a draw
   elsif draw?(board)
 #    tell the players it has been a draw
     puts "Cats Game!"
   end
end




def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]

    place_1 = board[win_index_1]
    place_2 = board[win_index_2]
    place_3 = board[win_index_3]

    if (place_1 == "X" && place_2 == "X" && place_3 == "X") || (place_1 == "O" && place_2== "O" && place_3 == "O")
      return win_combo
    end
  end
  return false
end
=begin
def full?(board)
  if board.any? {|i| i == " "}
    return false
  else
    return true
end
end

=end
def full?(board)
  board.all? {|i| i == "O" || i== "X"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    return true
  end
end

def winner(board)
  winn= won?(board)
  if over?(board) # need to put this over in so that in case it draws we show no winner
  if winn.all? {|i| board[i] == "X"}
    return "X"
  elsif winn.all? {|i| board[i] == "O"}
    return "O"
  else
    return nil
  end
end
end
=begin
def play(board)
     until over?(board) do
     turn(board)
     end

     if !!won?(board) == true
       puts("Congratulations #{winner(board)}!")
     else
       puts("Cats Game!")
     end

 end
=end
