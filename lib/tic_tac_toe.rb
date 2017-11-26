def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (user_input)
  user_input.to_i - 1
end

def move(board,pos,char)
  board[pos]=char
  return board
end

def valid_move?(board, index)
  if index > 8 || index < 0
    return false
  elsif position_taken?(board,index)
    return false
  else
    return true
  end
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def won?(board)
  WIN_COMBINATIONS.each do |z|
    if board [z[0]] != " " && board [z[0]]==board [z[1]] && board [z[1]]==board [z[2]]
      return z
    end #of if statement
  end #of do loop
  return false
end #of method definition

def full?(board)
  return false if board.include?(" ")
  return true
end

def draw?(board)
  return true if !won?(board) && full?(board)
  return false
end

def over?(board)
  return true if draw?(board)
  return true if won?(board)
  return false
end

def winner(board)
  return board [won?(board) [0]] if won?(board) != false
  return nil
end

def turn_count(board)
  counter = 0
  board.each {|x| counter +=1 if x != " " }
  counter
end

def current_player(board)
  if turn_count(board)%2 == 0
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  turn_in = gets.chomp
  turn_in = input_to_index(turn_in)
  is_valid = valid_move?(board,turn_in)
  if !is_valid
    turn(board)
  end
  move(board,turn_in,"X")
  display_board(board)
end