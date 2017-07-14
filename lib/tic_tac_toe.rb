def play(board) #TODO
 until(over?(board))
   turn(board)
 end
 if won?(board) != false
   puts "Congratulations #{winner(board)}!"
 elsif draw?(board)
   puts "Cats Game!"
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

def position_taken?(board, index) #returns true if there is a X or O at index, false if it's empty
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], #bot row
  [0,4,8], #\ diag
  [2,4,6],  # / diag
  [0,3,6], #left col
  [1,4,7], #mid col
  [2,5,8] #right col
]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
      if board[combination[0]] == "X" || board[combination[0]] == "O"
        return combination
      end
    end
  end
  return false
end

def full?(board)
  board.none?{|index|  index.nil? || index == " "}
end

def winner(board)
  won = won?(board)
  if won != false
    return board[won[0]]
  else
    return nil
  end
end

def draw?(board)
  full?(board) && won?(board) == false
end

def over?(board)
  draw?(board) || won?(board) != false
end

def turn_count(board) #returns the number of turns that have been played
  counter = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  player = turn_count(board) % 2 == 0 ? "X" : "O"
end

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

#def position_taken?(board, location)
#  board[location] != " " && board[location] != ""
#end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
