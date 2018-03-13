def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(board,index,character)
  board[index] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if !position_taken?(board,index) && index.between?(0,8)
    return true
  else
    return false
  end
end

def turn_count(board)
  turnNum = 0
  board.each do |position| 
    if position != "" && position != " "
      turnNum += 1
    end
  end
  return turnNum
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top
  [3,4,5], # Middle
  [6,7,8], # Bottom
  [0,4,8], # L->R diag 
  [2,4,6], # R->L diag 
  [0,3,6], # L column
  [1,4,7], # Centre column
  [2,5,8]  # R column
  ]

def won?(board)
  WIN_COMBINATIONS.detect do |combos|
    board[combos[0]] == board[combos[1]] && board[combos[1]] == board[combos[2]] && position_taken?(board,combos[0])
  end
end

def full?(board)
  board.all? {|position| position == "X" || position == "O"}
end

def draw?(board)
  full?(board) ? (won?(board) ? false : true) : false
end
    
def over?(board)
  (won?(board) || draw?(board) || full?(board)) ? true : false
end

def winner(board)
  combo = won?(board)
  combo ? board[combo[0]] : nil
end

# Define your play method below
def play(board)
  until over?(board) 
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
