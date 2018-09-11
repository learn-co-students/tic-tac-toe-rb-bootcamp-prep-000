WIN_COMBINATIONS =[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board (board)
 puts " #{board[0]} | #{board[1]} | #{board[2]} "
 puts "-----------"
 puts " #{board[3]} | #{board[4]} | #{board[5]} "
 puts "-----------"
 puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
   user_input.to_i - 1
end

def player_move (board,index,char)
  board[index] = char
end

def position_taken? (board,index)
  taken = nil
  if (board[index] == " " || board[index] == "" || board[index] == nil)
    taken = false
  else
    taken = true
  end
end

def valid_move?(board, index)
  if (index.between?(0,8) && !position_taken?(board,index))
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
    answer = input_to_index(input)
    if valid_move?(board,answer)
      player_move(board,answer,current_player(board))
      display_board(board)
  else
    puts "Invalid Entry!"
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
  if turn_count(board) % 2 ==0
    current_player = "X"
  else
    current_player = "O"
  end
return current_player
end

def won?(board)
  WIN_COMBINATIONS.each do |combo| 
  if board[combo[0]] != " " && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
    return combo
  end
  end
  return false
end

def full? (board)
  if board.detect { |i| i == " " }
    return false
  else 
    return true
  end
end

def draw? (board)
  if !won?(board) && full?(board)
    return true
    puts "Cat's Game!"
  else
    return false 
  end
end

def over? (board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner (board)
  game_winner = won?(board)
  if game_winner 
    board[game_winner[0]]
  end
end

def play(board)
  until over?(board)
current_player(board)
turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end