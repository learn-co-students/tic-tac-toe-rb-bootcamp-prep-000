WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (input)
  index = input.to_i - 1
  return index
end

def move (board, index, token)
  board[index] = token
end

def position_taken? (board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move? (board, index)
    if position_taken?(board, index)
      return false
    elsif index.between?(0, 8)
      return true
    else
      return false
    end
end

def turn (board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = ""
  if turn_count(board) == 0 || turn_count(board).even? == true
    token = "X"
  else
    token = "O"
  end
  until valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, token)
  display_board(board)
end

def turn_count (board)
  turnsPlayed = 0
  board.each do |token|
    if token == "X" || token == "O"
      turnsPlayed += 1
    end
  end
  return turnsPlayed
end

def current_player (board)
  remainder = turn_count(board) % 2
  remainder == 0 ? "X" : "O"
end

def won? (board)
  WIN_COMBINATIONS.any?{|winCombination|
    if board[winCombination[0]] == "X" && board[winCombination[1]] == "X" && board[winCombination[2]] == "X"
      return winCombination
    end
    }
  WIN_COMBINATIONS.any?{|winCombination|
    if board[winCombination[0]] == "O" && board[winCombination[1]] == "O" && board[winCombination[2]] == "O"
      return winCombination
    end
    }
end

def full? (board)
  notFull = board.include?(" ")
  if notFull == true
    return false
  else
    return true
  end
end

def draw? (board)
  won = won?(board)
  full = full?(board)
  if won == false && full == true
    return true
  elsif won == false && full == false
    return false
  else
    return false
  end
end

def over? (board)
  won = won?(board)
  draw = draw?(board)
  full = full?(board)
  if won != false || draw == true || full == true
    return true
  else
    return false
  end
end

def winner (board)
  won = won?(board)
  if won != false
    return board[won[0]]
  else
    return nil
  end
end

def play (board)
  until over?(board)
    turn(board)
    draw?(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
