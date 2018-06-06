WIN_COMBINATIONS = [
  [0,1,2], #top row  
  [3,4,5], #mid row
  [6,7,8], #bottom row
  [0,4,8], #diag top left
  [2,4,6], #diag top right
  [0,3,6], #left col
  [1,4,7], #mid col
  [2,5,8]  #right col
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
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.select{|position| position == "X" || position == "O"}.length
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_array| #iterate through win conditions
    if position_taken?(board, win_array[0]) #check if first position of win condition is taken
      token = board[win_array[0]] #get the token from the first position to check
      if win_array.all? do |position| #check if all positions in the win condition have the token
          board[position] == token
        end
        return win_array #return the win condition
      end  
    end
  end
  false
end

def full?(board)
  board.all?{|position| position == "X" || position == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winning_board = won?(board)
  if winning_board
    board[winning_board[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
