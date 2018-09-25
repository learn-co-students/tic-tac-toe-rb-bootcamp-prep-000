WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  if input.to_i.to_s == input
    index = input.to_i - 1
  else
    index = -1
  end
end
  
def player_move(board, index, symbol)
  board[index] = symbol
end

def valid_move?(board, index)
  if index >= 0 && index < 9
    if !position_taken?(board, index)
      true
    else
      false
    end
  else
    false
  end
end
  
def position_taken?(board, index)
  if board[index] == nil || board[index] == "" || board[index] == " "
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if !valid_move?(board, index)
    turn(board)
  else
    if current_player(board) == "X"
      player_move(board, index, "X")
    else
      player_move(board, index, "O")
    end
  end
end

def turn_count(board)
  num_of_turns = 0
  board.each do |token|
    if token != " "
      num_of_turns += 1
    end
  end
  num_of_turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    token = "X"
  else
    token = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    end
    if board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  false
end

def full?(board)
  if board.any?{|position| position == " "}
    false
  else
    true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  if over?(board)
    winner = board[won?(board)[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
    display_board(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end