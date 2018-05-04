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
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]
    if position_1 == position_2 && position_1 == position_3 && (position_1 == "O" || position_1 == "X")
      return win_combination
    else 
      return false 
    end 
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn_count(array)
  counter = 0 
  array.each do |index|
    (index == "X" || index == "O") ? counter += 1 : nil
  end 
  return counter
end

def draw?(array)
  (!won?(array) && turn_count(array) == 9) ? true : false 
end 

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player = "X")
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
    move(board, index)
    display_board(board)
  end
  if (won?(board))
    return "Congratulations #{board[index]}!"
  else if (draw?(board))
    return "Game drawn"
  else 
    turn(board)
  end
end

