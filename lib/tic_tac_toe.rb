# Define your WIN_COMBINATIONS constant
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
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  if user_input.is_a?Array
    user_input_int = user_input.join.to_i
  else
    user_input_int = user_input.to_i
  end  
  return -1 if user_input.length > 1
  user_input_int - 1
end 

def move(board, position, player)
  
  if board[position] == " "
    board[position] = player
  else
    puts "position already taken, next player please"
  end
  board
end  

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !(position_taken?(board, index))
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input_as_index = input_to_index(input)
  if ! valid_move?(board, input_as_index) 
    turn(board)
  else
    move(board, input_as_index, current_player(board))
    display_board(board)
  end  
end

def turn_count(board) 
  count_x = board.count("X") 
  count_o = board.count("O")
  count_x + count_o
end

def current_player(board)
  turn_count(board).even? ?  "X" : "O"
end

def won?(board)
  win_combination = []
  winner = []
  WIN_COMBINATIONS.each do |combination|
    if position_taken?(board, combination[0]) && position_taken?(board, combination[1]) && position_taken?(board, combination[2]) && board[combination[0]] == board[combination[1]] && board[combination[0]] == board[combination[2]]
       win_combination << combination
       winner << board[combination[0]]
    end   
  end
  win_combination.length == 1 || (win_combination.length == 2 && winner[0] == winner[1])? win_combination[0] : nil
end

def full?(board)
  count = 0
  board.each.with_index do |position, index| 
    if position_taken?(board, index) 
      count += 1
    end  
  end
  count == 9 ? true : false
end

def draw?(board)
  full?(board) && won?(board) == nil
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board) != nil ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    
  end  
end  
