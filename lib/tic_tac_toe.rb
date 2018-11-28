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

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  elsif won?(board).class == Array
    puts "Congratulations #{winner(board)}!"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #slash
  [2, 4, 6] #backslash
]

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
      win_index_1 = win_combination[0] #first position in winning combo
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1] #what's in that position on board?
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
        false
    end
  end
end

def full?(board)
  board.all? do |space|
    (space == "X" || space == "O")
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif !full?(board)
    return false
  else
    return true
  end
end

def over?(board)
  if (draw?(board) || won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  check_board = won?(board)
  if check_board.class == Array
    return board[check_board[0]]
  else
    nil
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if (space == "X" || space == "O")
      counter+=1
    end
  end
return counter
end

def current_player(board)
  turns = turn_count(board)
  if turns.even?
    return "X"
  else
    return "O"
  end
end
