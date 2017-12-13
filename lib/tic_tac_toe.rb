WIN_COMBINATIONS = [
  [0, 1, 2], 
  [3, 4, 5], 
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7], 
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
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

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, board.length - 1) && !position_taken?(board, index)
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
  count = 0
  board.each do |element|
    if element == 'X' or element == 'O'
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]]
    position_2 = board[win_combination[1]]
    position_3 = board[win_combination[2]]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination # return the win_combination indexes that won.
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination # return the win_combination indexes that won.
    end
  end
  return false
end

def full?(board)
  board.include?(" ") ? false : true
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  end
end

def over?(board)
  draw?(board) or !board.include?(" ") or won?(board) ? true : false
end

def winner(board)
  if !won?(board)
    nil
  elsif board[won?(board)[0]] == "X"
    "X"
  else
    "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations " + winner(board) + "!"
  else
    puts "Cats Game!"
  end
end
