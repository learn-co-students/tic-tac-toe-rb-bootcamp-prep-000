WIN_COMBINATIONS =[
  [0,1,2],#top row
  [3,4,5],#mid-row
  [6,7,8], #bottom
  [0,3,6],#left
  [1,4,7], #middle
  [2,5,8], #right
  [0,4,8], #diag top left
  [2,4,6], #diag top right
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(number)
  (number.to_i)-1
end

def move(board,index,character)
  board[index]= character
end

def position_taken?(board,index)
if board[index] == " "||board[index]==""||board[index]==nil
  false
else
  true
end
end


def valid_move?(board,index)
!position_taken?(board,index)&&index.between?(0,8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board,index)
    turn(board)
  else
    move(board,index,character=current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  turn_count = 0
  board.each do |space|
    if space != " "
      puts "#{space} is occupied"
      turn_count+=1
    end
  end
  return turn_count
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def won?(board)
WIN_COMBINATIONS.each do |combo|
  if (board[combo[0]]=="X"&& board [combo[1]]=="X"&& board [combo[2]]=="X")||
    (board[combo[0]]=="O"&& board [combo[1]]=="O"&& board [combo[2]]=="O")
    return combo
end
end
return false
end

def full?(board)
  board.all? do |index|
    index!=" "
  end
end

def draw?(board)
!won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if winner_index =won?(board)
    board[winner_index[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
