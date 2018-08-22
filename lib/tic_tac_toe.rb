WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]
  
  
  def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
  input.to_i-1
end


def move(board, index, player)
  board[index]=player
  display_board(board)
end


def position_taken?(board,index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
    elsif board[index] == "X" || board[index] == "O"
    true
  end
end


def valid_move?(board,index)
  if position_taken?(board,index) == false && index.between?(0,8)
    true
  else
    false
  end
end


def turn(board)
  puts "Please enter 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index, current_player(board))
  else
    turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end


def current_player(board)
  turn = turn_count(board)
  if turn.odd?
    player = "O"
  else
    player = "X"
  end
end


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
  return false
end


def full?(board)
  board.each do |space|
    if space == " "
      return false
    else
      true
    end
  end
  return true
end


def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  end
end

def over?(board)
  if won?(board).kind_of?(Array) || full?(board) == true || draw?(board) == true
    return true
  end
end


def winner(board)
  if won?(board).kind_of?(Array)
    ace=won?(board)
    return board[ace[0]]
  else
    nil
  end
end

def play(board)
  while !over?(board)
  turn(board)
  end
  if won?(board).kind_of?(Array)
    return "Congratulations Player #{winner(board)}"
  elsif draw?(board) == true
    return "Cat's Game!"
  end
end
