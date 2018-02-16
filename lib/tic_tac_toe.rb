WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn_count(board)
  result = 0
  board.each do |index|
    if index != " " && index != ""
      result+=1
    end
  end
  return result
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return 'X'
  end
  return 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each value from the board in the win_combination positions that composes a win.
    position = [board[win_combination[0]], board[win_combination[1]], board[win_combination[2]]]

    if position[0] == "X" && position[1] == "X" && position[2] == "X"
      return win_combination # return the win_combination indexes that won.
    end
    if position[0] == "O" && position[1] == "O" && position[2] == "O"
      return win_combination # return the win_combinationo indexes that won.
    end
  end
  return false
end

def full?(board)
  board.each do |position|
    if position == " " || position == nil
      return false
    end
  end
  return true
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  return false
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    # "|| draw?(board)" < cant be true without a nother evaluation being true
    return true
  end
  return false
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each value from the board in the win_combination positions that composes a win.
    position = [board[win_combination[0]], board[win_combination[1]], board[win_combination[2]]]

    if position[0] == "X" && position[1] == "X" && position[2] == "X"
      return "X" # return the winner.
    end
    if position[0] == "O" && position[1] == "O" && position[2] == "O"
      return "O" # return the winner.
    end
  end
  return nil
end

# Helper Methods
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
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
