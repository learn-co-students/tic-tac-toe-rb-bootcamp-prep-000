##constants
WELCOME_MESSAGE = "Welcome to Tic Tac Toe!"
INPUT_PROMPT = "Please enter 1-9:"
INVALID_INPUT = "That is not a valid move."
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


#board display methods
def br
  print("\n")
end
def l_cell(arg = " ")
    print(" #{arg} |")
end
def r_cell(arg = " ")
  print(" #{arg} ")
  br
end
def sep 
  11.times do 
    print "-" 
  end
  br
end
def row(arg_x, arg_y, arg_z)
    l_cell(arg_x)
    l_cell(arg_y)
    r_cell(arg_z)
end

def display_board(arg = [" "," "," "," "," "," "," "," "," "])
  row(arg[0], arg[1], arg[2])
  sep
  row(arg[3], arg[4], arg[5])
  sep
  row(arg[6], arg[7], arg[8])
end

#movemaking methods

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

#move verification methods

  # check if the specified position is on the board
def move_on_board?(board, index)
  if index >= 0 && index <= 8
    true 
  else
    false
  end
end 

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  # apply both tests and return the result
  if move_on_board?(board, index) && !position_taken?(board, index)
    true
  else
    false
  end
end


##player counter methods
def turn_count(board)
  turn_counter = 0
  board.each do |space|
    if space == nil  
    elsif space.strip != ""
      turn_counter += 1
    end
  end
  turn_counter
end

def current_player(board) 
  turn_count(board).even? ? "X" : "O"
end


##victory methods
 def won?(board)
   
  # set return variable to default value. By default nobody has won.
  return_val = false
  
  #drop down a level in the array of winning combinations
  WIN_COMBINATIONS.each do |comb| 
  
    # pass tests for "X" and "O" to #all? 
    if comb.all? {|space| board[space] == "X"} || comb.all? {|space| board[space] == "O"}
      return_val = comb
    end
  end
  #return new return value
  return_val
 end
   
def full?(board)
  return_val = true
    
    board.each_index do |cell| 
      if !position_taken?(board, cell)
        return_val = false
      end
    end
  return_val
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else 
    false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  elsif draw?(board)
    board[won?(board)[0]]
  end
end
##turn method

def turn(board)
  puts INPUT_PROMPT
  choice = gets.chomp
  choice = input_to_index(choice)
  truthiness = valid_move?(board, choice)
  if !truthiness
    puts INVALID_INPUT
    turn(board)
  else
    move(board, choice, char = current_player(board))
    display_board(board)
  end  
end

##play method

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