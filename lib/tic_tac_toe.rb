WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
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

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  character = current_player(board)
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_number = 0

  board.each do |board_number|
    if (board_number != "" && board_number != " " && board_number != nil)
      turn_number += 1
    end
  end

  return turn_number
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    if (board[win_combination[0]] == "X" && board[win_combination[1]] == "X" && board[win_combination[2]] == "X") || (board[win_combination[0]] == "O" && board[win_combination[1]] == "O" && board[win_combination[2]] == "O")

      return win_combination
    end
  end
  return false
 end

 def full?(board)
   board.each_with_index do |character, index|
     if !position_taken?(board, index)
       return false
     end
   end
   return true
 end

 def draw?(board)
  if !won?(board)
    if full?(board)
      return true
    end
  elsif !won?(board) && !full?(board)
    return false
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  x = won?(board)
  if won?(board)
    return board[x[0]]
  end
end

def play(board)
   until turn_count(board) == 8
    
    turn(board)

    if over?(board)
      puts winner(board)
      # break
    end
   end
end