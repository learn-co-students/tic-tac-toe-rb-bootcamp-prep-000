def display_board(board)
  puts row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, index, position)
  board[index] = position
end

def valid_move?(board, index)
  if index>= 0 && index <=8
    if position_taken?(board, index) == false
      return true
    else return false
    end
  else return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  goodInput = false
  while goodInput == false
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index) == true && position_taken?(board, index) == false
      move(board, index, current_player(board))
      goodInput = true
      display_board(board)
    else 
      puts "Not a valid move! Try again"
    end
  end
end

def input_to_index(input)
  index = input.to_i
  if !index 
    return -1
  else
    return index -= 1
  end
end

def turn_count(board)
  xTurnsTaken = 0
  oTurnsTaken = 0
  board.each do |space|
    if space == "X"
      xTurnsTaken += 1
    elsif space == "O"
      oTurnsTaken += 1
    end
  end
  turnsTaken = xTurnsTaken + oTurnsTaken
end

def current_player(board)
  turnToGo = turn_count(board)
  if turnToGo%2 == 0
    return "X"
  else
    return "O"
  end
end
  
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    index0 = win_combo[0]
    index1 = win_combo[1]
    index2 = win_combo[2]
    if board[index0] == "X" && board[index1] == "X" && board[index2] == "X"
      return win_combo
    elsif board[index0] == "O" && board[index1] == "O" && board[index2] == "O"
      return win_combo
    end
  end
  return false
end

def full?(board)
  count = -1
  check = board.all? do |i|
    count += 1
    position_taken?(board, count)
  end
  check
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if full?(board) || draw?(board) || won?(board) != false
    return true
  else return false
  end
end 

def winner(board)
  if won?(board) != false
    winningCombo = won?(board)
    teamWin = board[winningCombo[0]]
    return teamWin
  else return nil
  end
end

def play(board)
  while !(over?(board))
    turn(board)
    won?(board)
  end
  if won?(board) != false
    winnerTeam = winner(board)
    puts "Congratulations #{winnerTeam}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end