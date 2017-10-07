WIN_COMBINATIONS = [
  [0,1,2], # Top Row Win
  [3,4,5], # Middle Row Win
  [6,7,8], # Bottom Row Win
  [0,3,6], # First Column Win
  [1,4,7], # Second Column Win
  [2,5,8], # Third Column Win
  [0,4,8], # Diagonal Win from Left
  [6,4,2]  # Diagonal Win from Right
]
def display_board(board)
    puts " #{board[0]}" " |" " #{board[1]}" " |" " #{board[2]} "
    puts "-----------"
    puts " #{board[3]}" " |" " #{board[4]}" " |" " #{board[5]} "
    puts "-----------"
    puts " #{board[6]}" " |" " #{board[7]}" " |" " #{board[8]} "
end

def input_to_index(user_input)
    user_input.to_i - 1
end

def move(board, index, current_player)
    board[index] = current_player
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
     return false
  else
    return true
  end
end

def valid_move?(board, position)
    if position_taken?(board, position) == true || position.between?(0,8) == false
      return false
    else
        return true
    end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  position = input_to_index(user_input)
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |player|
    if player == "X" || player == "O"
      counter += 1
    end
  end
  counter
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
  wins_combo = false
  if board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    return false
  else
    WIN_COMBINATIONS.each do |wins|
      char1 = "X"
      char2 = "O"
      if board[wins[0]] == char1 && board[wins[1]] == char1 && board[wins[2]] == char1 || board[wins[0]] == char2 && board[wins[1]] == char2 && board[wins[2]] == char2
        wins_combo = wins
    end
  end
  wins_combo
end
end

def full?(board)
  board.none?{|spaces| spaces == " "}
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  end
end

def over?(board)
  if draw?(board)
    return true
  elsif full?(board)
    return true
  elsif won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  win_combo = won?(board)
  if win_combo
    index = win_combo[0]
    return board[index]
  else
    return nil
  end
end


def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
