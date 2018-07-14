# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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

def turn_count(board)
  array_of_filled = board.select{|i| i == "X" || i == "O"}
  return array_of_filled.size
end

def move(board, index, character)
  if !position_taken?(board, index)
    if (turn_count(board) + 1) % 2 == 1
      board[index] = character
    else
      board[index] = character
    end
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  until valid_move?(board, index)
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  #rows
  [0,1,2],
  [3,4,5],
  [6,7,8],
  #columns
  [0,3,6],
  [1,4,7],
  [2,5,8],
  #diagnals
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |condition|
    if board[condition[0]] == "X" && board[condition[1]] == "X" && board[condition[2]] == "X"
      return condition
    elsif board[condition[0]] == "O" && board[condition[1]] == "O" && board[condition[2]] == "O"
      return condition
   end
 end
 return false
end

def full?(board)
  array_of_filled = board.select{|i| i == "X" || i == "O"}
  if array_of_filled.size == 9
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end


def over?(board)
  if full?(board) == true || won?(board) != false || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    combination = won?(board)
    winner = board[combination[0]]
    return winner
  end
  return nil
end

