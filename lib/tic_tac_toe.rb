WIN_COMBINATIONS = [
  [0,1,2],            #top row 
  [3,4,5],            #middle row
  [6,7,8],            #bottom row
  
  [0,3,6],            #left column
  [1,4,7],            #middle column
  [2,5,8],            #right column
  
  [0,4,8],            #TL-BR diagonal
  [2,4,6],            #TR-BL diagonal
]

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

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index <= board.length - 1 && index >= 0 && position_taken?(board, index) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |i|
    if position_taken?(board, board.index(i))
      counter += 1
    end
  end
  return counter
end

def current_player(board) 
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end
          
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    positions = []
    counter = 0
    
    combo.each do |i|
      positions[counter] = i
      counter += 1
    end
  
    positions.all? do |n|
      position_taken?(board,n)
    end
    
    if board[positions[0]] == "X"
      positions.all? do |m|
        board[m] == "X"
      end
    elsif board[positions[0]] == "O"
      positions.all? do |q|
        board[q] == "O"
      end
    end
  end
end

def full?(board)
  board.all? do |i|
    position_taken?(board, board.index(i))
  end
end
      
def draw?(board)
  if won?(board)
    return false
  else
    if full?(board)
      return true
    else
      return false
    end
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  elsif won?(board) == nil
    return nil
  end
end

def play(board) 
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat\'s Game!"
  end
end

