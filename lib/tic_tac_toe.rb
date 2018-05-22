WIN_COMBINATIONS = [
  [2,4,6],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [0,3,6],
  [0,1,2],
  [1,4,7],
  [2,5,8]
]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn = 0
  board.each do |space|
    if space == "X" || space == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  turn = turn_count(board)
  if turn.even? 
    return "X"
  else
    return "O"
  end
end

def won?(board)
    WIN_COMBINATIONS.each do |combo|
      if combo.all? {|space| board[space] == "X"}
        return combo
      elsif combo.all? {|space| board[space] == "O"}
        return combo
      end
    end
    return FALSE
  end
  
  def full?(board)
    if board.all? {|space| space == "X" || space == "O"}
      return TRUE
    else
      return FALSE
    end
  end
  
  def draw?(board)
    if won?(board) == FALSE && full?(board) == TRUE
      return TRUE
    else
      return FALSE
    end
  end
  
  def over?(board)
    if won?(board) != FALSE || draw?(board) == TRUE
      return TRUE
    else
      return FALSE
    end
  end
  
  def winner(board)
    if won?(board) != FALSE
      return board[won?(board)[0]]
    end
  end
  
  def play(board)
    until over?(board)
      turn(board)
    end
    if draw?(board) == TRUE
      puts "Cat's Game!"
    else 
      puts "Congratulations #{winner(board)}!"
    end
  end
  
    