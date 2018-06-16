def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1 
end

def turn_count(board)
  board.count do |token|
    token == 'X' || token == 'O'
  end 
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return 'X'
  else
    return 'O'
  end
end
    
def move(board, position, player_token)
  board[position] = player_token
end

def valid_move?(board, index)
  if board[index] != 'X' && board[index] != 'O' && index.between?(0,8)
    return true 
end
end

def turn(board)
  puts 'Please enter 1-9:'
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board,index)
    turn(board)
  end
    move(board, index, current_player(board))
    display_board(board)
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # mid row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # diag1
  [2,4,6] # diag2
  ]

def won?(board)
  WIN_COMBINATIONS.detect do |arr|
    if board[arr[0]] == board[arr[1]] && board[arr[0]] == board[arr[2]] && board[arr[0]] != ' '
      return arr
    end
  end
end
       
def full?(board)
  board.all? do |element|
    element == 'X' || element == 'O'
    end
end

def draw?(board)
 if !won?(board) && full?(board)
   return true
 end
end

def over?(board)
  if full?(board) || won?(board) 
    return true
  end
end

def winner(board)
  if won?(board)
    arr = won?(board)
  return board[arr[0]]
end
end

def play(board)
  until over?(board) || draw?(board)
  turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts 'Cat\'s Game!'
  end
end