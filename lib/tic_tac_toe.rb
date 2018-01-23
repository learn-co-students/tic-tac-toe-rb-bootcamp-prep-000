def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  int=input.to_i
  return index= int - 1
end

def move(board,index,character)
  board[index]=character
  return board
end


def position_taken?(board,index)
  if board[index]==" "||board[index]==""|| board[index]== nil
    return false
  else
    return true
  end
end

def valid_move?(board,index)
  if position_taken?(board,index) == false && index.between?(0,8)
    return true
  else
    return false
  end
end
def turn_count(board)
  counter = 0
  board.each do |index|
    if index== "X" || index== "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 ==0
    return "X"
  elsif turn_count(board) % 2 ==1
    return "O"
  end
end


def turn(board)
  puts "Please enter 1-9:"

  input=gets.strip
  index=input_to_index(input)

    if valid_move?(board,index)
    character=current_player(board)
    move(board,index,character)
    #board[index]="X"
    display_board(board)
  else
    #until valid_move?(board,index)
      turn(board)
    #end
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS=[
  [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]
]





def won?(board)
  WIN_COMBINATIONS.each do |combination|
    index1=combination[0]
    index2=combination[1]
    index3=combination[2]

    if board[index1]=="X" && board[index3]=="X" && board[index2]=="X"
        return combination

    elsif board[index1]=="O" && board[index3]=="O" && board[index2]=="O"
        return combination
    end
  end
  return false
end

def full?(board)
  board.all? do |index|
    index=="X"||index=="O"
  end
end

def draw?(board)
  if full?(board)== true && won?(board)== false
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board)!= false || draw?(board)== true || full?(board)== true
    return true
  else
    return false
  end
end

def winner(board)
  if win = won?(board)
    board[win[0]]
  #elsif won?(board).each do |index|
   #board[index]== "X"
    #end
    #return "X"

  #else
    #return "O"
  end
end


def play(board)
  #counter=0
  #until counter == 9
  until over?(board) == true
    turn(board)
    #counter +=1
  end
  if won?(board)!= false
    winner=winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)== true
    puts "Cat's Game!"
  end
end
