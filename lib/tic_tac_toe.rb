# Helper Method
require 'set'

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
  [2,4,6]
]


#display_board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


#input_to_index
def input_to_index(user_input)
  user_input.to_i - 1
end


#move
def move(board, index, current_player)
  board[index] = current_player
end


#position_taken?
def position_taken?(board, location)
  board[location] != " 
end


#valid_move?
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


#turn
def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))          #maybe add current_player
    display_board(board)
  else
    turn(board)
  end
end


#turn_count
def turn_count(board)
  count = 0
  board.each { |val| count += 1 if val != " "}
  return count
end


#current_player
def current_player(board)
  if turn_count(board)%2 == 0
    return "X"
  else
    return "O"
  end
end


#Won
def won?(board)
  xSet=Set[]
  oSet=Set[]
  
  #load x's in board into Array
  board.each_with_index do |val, i|
    if val == "X"
      xSet << i
    end
  end
  
  #load o's in board into Array
  board.each_with_index do |val, i|
    if val == "O"
      oSet << i
    end
  end
  
  #for each win combo, check if inside x's/o's array if so return that combo
  WIN_COMBINATIONS.each do |v|
    if v.to_set.subset?(xSet)
      return v
    end
  end
  WIN_COMBINATIONS.each do |v|
    if v.to_set.subset?(oSet)
      return v
    end
  end
  return false
end


#full
def full?(board)
  #false if any in full = " " or nil
  if board.any? {|space| space == " "}
    return false
  end
  return true
end


#draw
def draw?(board)
  #True if full and !won?
  if full?(board) and not won?(board)
    return true
  end
  return false
end


#over?
def over?(board)
  #true if full or won(truthy) or draw
  if won?(board) or full?(board) or draw?(board)
    return true
  end
  return false
end


#winner
def winner(board)
  if !over?(board)
    return nil
  end
  winner = won?(board) #set winner to array returned
  if board[winner[0] ] == "X"
   return "X"
  else board[winner[0] ] == "O"
    return "O"
  end
end


#play
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
