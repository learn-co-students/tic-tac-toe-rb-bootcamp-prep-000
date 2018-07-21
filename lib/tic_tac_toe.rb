board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

WIN_COMBINATIONS =  [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(the_board)
  puts " #{the_board[0]} | #{the_board[1]} | #{the_board[2]} "
  puts "-----------"
  puts " #{the_board[3]} | #{the_board[4]} | #{the_board[5]} "
  puts "-----------"
  puts " #{the_board[6]} | #{the_board[7]} | #{the_board[8]} "
end



def input_to_index(input)
  input.to_i - 1 
end



def move(array,index,character)
  array[index] = character
end



def position_taken?(board, index)
  taken = nil
   if (board[index] ==  " " || board[index] == "" || board[index] == nil)
     taken = false
   else
     taken = true
  end
end


def valid_move?(board,index)
  if position_taken?(board,index) || !(index.between?(0,8))
    false
  else
    true
  end
end

def turn(board)
  puts "Enter a number from 1-9:"
  number = gets.strip
  index = input_to_index(number)
  if valid_move?(board, index)
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end 
end

def turn_count(board)
  counter = 0
  board.each do |character|
    if character == "X" || character == "O"
      counter += 1
    end 
  
  end 
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else 
    return "O"
  end
end

def won?(board)
  winner = nil
  WIN_COMBINATIONS.each do |combo|
    if combo.all? {|idx| board[idx] == "X"}
      winner = combo
    elsif combo.all? {|idx| board[idx] == "O"}
      winner = combo
    else
      false
    end
  end
  if winner != nil
    winner
  else
    false
  end
end


def winner(board)
  winner = nil
  WIN_COMBINATIONS.each do |combo|
    if combo.all? {|idx| board[idx] == "X"}
      winner = "X"
    elsif combo.all? {|idx| board[idx] == "O"}
      winner = "O"
    else
    end
  end
  winner
end




def full?(board)
  board.all?{ |token| token == "X" || token == "O"}
end

def draw?(board)
  if full?(board) && !(won?(board))
    true
  else
    false 
  end
end


 def over?(board)
  if full?(board) || won?(board) || draw?(board)
    true
  else
    false
  end
end



def play(board)
  board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    try_again?(board)
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def try_again?(board)
  puts "Would you like to play again? Type Yes or No"
    input = gets.strip
    if input.downcase == "yes"
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      display_board(board)
      play(board)
    else
      puts" thank you for playing"
      over?(board)
    end
end
      



