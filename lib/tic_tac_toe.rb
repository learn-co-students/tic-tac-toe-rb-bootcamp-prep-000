WIN_COMBINATIONS = [
  [0,1,2], #top row winner
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left vertical
  [1,4,7], #middle vertical
  [2,5,8], #right vertical
  [0,4,8], #diagonal 1
  [2,4,6] #diagonal 2
]

def display_board(moves)
  puts " #{moves[0]} | #{moves[1]} | #{moves[2]} "
  puts "-----------"
  puts " #{moves[3]} | #{moves[4]} | #{moves[5]} "
  puts "-----------"
  puts " #{moves[6]} | #{moves[7]} | #{moves[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(array, index, character)
  array[index] = character
end

def position_taken?(board,index)
  if board[index] == " " ||  board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
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

def turn(board)
  puts "Please enter 1-9:"
  input=gets.strip
  index = input_to_index(input)
  if valid_move?(board,index) == true
    move(board, index, character ="X")
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |box|
    if box == "X" || box == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2 == 0
      return "X"
  else
      return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combo|
    board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X" ||
    board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
    end
end

def full?(board)
  board.all? do |space|
    space == "X" || space =="O"
  end
end

def draw?(board)
   if full?(board) && !won?(board)
     return true
   else
     return false
   end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  turn(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
