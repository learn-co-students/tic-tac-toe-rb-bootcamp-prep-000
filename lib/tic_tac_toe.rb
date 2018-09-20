#Helper Methods

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], #TopRow
  [3,4,5],  #MiddleRow
  [6,7,8], #bottomRow
  [0,3,6], #firstVertical
  [1,4,7], #SecondVert
  [2,5,8], #ThirdVert
  [0,4,8], #FirstDia
  [2,4,6] #SecondDia
]

def won?(board)
WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  position_1 = board[win_index_1] 
  position_2 = board[win_index_2] 
  position_3 = board[win_index_3]
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
    false
  end
  end
  false
end

# Postion Taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def winner(board)
WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  position_1 = board[win_index_1] 
  position_2 = board[win_index_2] 
  position_3 = board[win_index_3]
  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return "X"
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return "O"
  else
    nil
  end
  end
  nil
end

#turn_count

def turn_count(board)
  board.count {|z| z!= " "}
end


#current_player

def current_player(board)
  board.count {|z| z!= " "} % 2 == 0 ? "X" : "O"
end

#display_board

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!

def input_to_index(str)
  index = str.to_i - 1
end

def move(board, index, character ="X")
  board[index] = character
end


# code your #valid_move? method here

def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  elsif index.between?(0, 8)
    return true
  else
    return false
end
end


# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.

def position_taken?(board, index)
  if board[index] == nil || board[index] == " " || board[index] == ""
  return false
  elsif board[index] != nil
    return true
  end
end

#Turn method 

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
    if valid_move?(board, index)
      player_move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
end

def player_move(board, index, current_player)
  board[index] = current_player
end

#over?
def over?(board)
  #won?(board) == true || full?(board) == true|| draw?(board) == true ? true : false
  won?(board) || draw?(board)
end

#Draw? Method
def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
end
end

#Full? Method
def full?(board)
  board.none? {|x| x == " "}
end

#Play Method
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