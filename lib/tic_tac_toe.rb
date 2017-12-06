WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left vertical
  [1,4,7], #middle vertical
  [2,5,8], #right vertical
  [0,4,8], #forward diagonal
  [6,4,2]  #reverse diagonal
]

##################################

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

##################################

def input_to_index(user_input)
  user_input.to_i - 1
end

##################################

def move(array, index, value)
  array[index]= value
end

##################################

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

##################################

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board, index) == false
    true
  else
    false
  end

end

##################################

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board) )
    display_board(board)
    #turn(board)
  else
    turn(board)
  end
end

##################################

def turn_count(board)
  counter = 0
  board.each do |count|
    if count == "X"
      counter += 1
    elsif count == "O"
      counter += 1
    end
  end
  counter
end

##################################

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  elsif turn_count(board) % 2 != 0
    return "O"
  end
end

##################################

def won?(board)

  WIN_COMBINATIONS.each do |win_combination|
    win_indexes = win_combination.all?{|index| position_taken?(board, index)}
      if win_indexes === true
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]

          if position_1 == "X" && position_2 == "X" && position_3 == "X"
              return win_combination
              #winner = "X"
          elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
              return win_combination
            #  winner = "O"

          end
        end
      end
    return false
end

#######################

def full?(board)
  board.none?{|index| index == " "}
end

######################

def draw?(board)
  if full?(board) && !won?(board) 
    return true
  elsif !won?(board) && !full?(board)
    return false
  elsif won?(board)
    return false
  end
end

#######################

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

########################

def winner(board)
  if over?(board)
    return board[won?(board)[0]]
  end
end

##################################

def play(board)
  until over?(board)
    turn(board)
  end

if won?(board)
  puts "Congratulations #{winner(board)}!"
elsif draw?(board)
  puts "Cat\'s Game!"
end
end
