BOARD = ["X"," ","X"," ","X"," ","O ","O"," "]
WIN_COMBINATIONS =[
    [0,1,2], #top row
    [3,4,5],
    [6,7,8],
    [0,3,6],  #left Column
    [1,4,7],
    [2,5,8],
    [0,4,8], #left diagnol
    [2,4,6]
  ]

# Helper Methods
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

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# takes player input and puts value on board if move is valid
def turn(board)
  # if draw?(board)
  #   puts "Cat's Game!"
  # elsif over?(board)  
  #   puts "Congratulations #{winner(board)}!"
  # else
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      token = current_player(board)
      player_move(board, index, token)
      display_board(board)
    else
      turn(board)
    end
  # end
end

#play loop 
def play(board)
  while !over?(board)
    turn(board)
  end
    if draw?(board)
    puts "Cat's Game!"
  else over?(board)  
    puts "Congratulations #{winner(board)}!"
end
end

#lets you know if a position is taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#returns the wining combination array or nil if no winner
def won?(board)
  sam_ex = []
  sam_oh = []
  i = 0
  board.each do |index|
    if index == "X"
      sam_ex.push(i)
    elsif index == "O"
      sam_oh.push(i)
    end
    i+=1
  end
  WIN_COMBINATIONS.each do |combination|
    if combination&sam_oh == combination || combination&sam_ex ==combination
    return  combination
    end
  end
  nil
end

#if all elements of board have a token that = X or O return true for a draw else game is in progress
def full?(board)
  if board.all?{|token| token == "X" || token =="O"}
    true #if all elements of board have a token that = X or O return true for a draw
  else
    false  #game is in progress
  end
end

#returns true if the game ended in a draw
def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

#returns true if game is a draw or someone won
def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

#returns an X or an O depending on which one won
def winner(board)
  won?(board)
  if won?(board)
   board[won?(board)[0]]
  end
end

#takes a board and index and puts current_player in board's index, the index is the number supplied by the player from 1-9. Will be called after we receive a player's input. Board is updated in this method with the number (index) supplied by the player.Use #current_player for last argument
def player_move(board, index, current_player_token)
  board[index] = current_player_token
end

#turn_count returns the number of plays that have been made. It is the number of X's and O's on the board
def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X" || token =="O"
      counter +=1
    end
  end
  counter
end

#Returns X or O for who the current player is. This method is called after a number has supplied by the user. It is used by the #player_move method.
def current_player(board)
  if (turn_count(board) + 1) %2 == 0
    "O"
  else
    "X"
  end
end

#same as turn_count not needed
def number_of_turns_taken(board)
  counter = 0
  board.each do |token|
    if token == "X" || token =="O"
      counter +=1
    end
  end
  counter
end
