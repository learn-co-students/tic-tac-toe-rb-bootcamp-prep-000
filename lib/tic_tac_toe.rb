WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, index, token)
  board[index] = token
  return board
end

def position_taken?(board, index)
  return board[index] != " "
end

def valid_move?(board,index)
  if !(0 <= index && index <= 8)
    return false
  end
  return !position_taken?(board, index)
end

def turn(board)
  puts("Enter a position 1-9")
  input = gets
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = board.select{|i| i == " "}.length
  if count == nil
    return 0
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "O"
  end 
  return "X"
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    player_won = combo.all?{|i| board[i] == "X"}
    cpu_won = combo.all?{|i| board[i] == "O"}
    if cpu_won || player_won
      return combo
    end 
  end
  return nil
end

def full?(board)
  return turn_count(board) == 0
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  w = won?(board)
  if w != nil
    return board[w[0]]
  end
  return nil
end

def play(board)
  until over?(board)
    turn(board) 
  end 
  winner = winner(board)
  if winner != nil
    puts("Congratulations #{winner}!")
  end
  if draw?(board)
    puts("Cat's Game!")
  end
end













