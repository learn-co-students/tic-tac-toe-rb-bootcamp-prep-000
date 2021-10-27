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

def input_to_index(input)
  input.to_i-1
end

def move(board, index, player)
  board[index] = player
  return board
end

def position_taken?(board, index)
  if board[index]==" "
    false
  else
    true
  end
end

def valid_move?(board, index)
  if !position_taken?(board,index) && index.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input=input_to_index(gets.strip)
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    puts "Please try again with 1-9:"
    turn(board)
  end
end

def turn_count(board)
  filledBoard = 0
  board.each do |turn|
    if (turn == "X" || turn == "O")
      filledBoard+=1
    end
  end
  return filledBoard
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.any? do |win|
    index_1 = win[0]
    index_2 = win[1]
    index_3 = win[2]
    
    position_1 = board[index_1]
    position_2 = board[index_2]
    position_3 = board[index_3]
    
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")||(position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win
    else
      false
    end
  end
end

def full?(board)
  board.all? do |move|
    move == "X" || move == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  elsif won?(board)
    false
  else
    false
  end
end

def over?(board)
  if won?(board) || (!won?(board) && full?(board)) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  winningCombo = won?(board)
  if winningCombo
    if winningCombo.any? {|win| board[win] == "X"}
      return "X"
    else 
      return "O"
    end
  end
end 

def play(board)
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board)
    puts "Cat's Game!"
  elsif !(over?(board))
    turn(board)
    play(board)
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end