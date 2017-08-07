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
  index = input.to_i - 1
end

def move(board, position, character = "X")
  board[position] = character
  board
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if index < 0 || index > 8
    false
  elsif position_taken?(board, index)
    false
  else
    true
  end
end

def move(board, index, player)
  board[index] = player
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
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
  return counter
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end



def won?(board)
  WIN_COMBINATIONS.each do |combination|
    win1 = combination[0]
    win2 = combination[1]
    win3 = combination[2]
    position1 = board[win1]
    position2 = board[win2]
    position3 = board[win3]
    if position1 == "X" && position2 == "X" && position3 == "X"
      return combination
    elsif position1 == "O" && position2 == "O" && position3 =="O"
      return combination
    end
  end
  return false
end

def full?(board)
  board.all? {|position| position=="X" || position=="O"}
end

def draw?(board)
  if full?(board) && won?(board) == false
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board) != false
    true
  else
    false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    board[won?(board)[0]] == "X" ? "X":"O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end 
