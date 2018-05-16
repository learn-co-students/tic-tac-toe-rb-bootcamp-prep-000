def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    end
    if position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
  end

def full?(board)
  return !(board.any? { |element| element == " " })
end
    
def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return won?(board) || draw?(board)
end

def winner(board)
  if win_combination = won?(board)
    board [win_combination[0]]
  end
end

def turn_count(board)
  counter = 0
  board.each do |place| 
    if place == "X" || place == "O"
      counter += 1
    end
  end
  return counter
  end

def current_player(board)
  return (turn_count(board) % 2 == 0) ? "X" : "O"
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, index, token)
  board[index] = token
end
  
def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  while !valid_move?(board, index)
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def input_to_index(input)
  return input.to_i - 1
end

# code your #valid_move? method here
def valid_move?(board, index)
  if position_taken?(board, index) || !index.between?(0, 8)
    return false
  end
  return true
end


def position_taken?(board, index)
  if board[index] == " "
    return false
  else
    return true
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end