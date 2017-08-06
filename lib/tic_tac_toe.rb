
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return user_input.to_i - 1
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  if !(index.between?(0, 8)) || position_taken?(board, index)
    return false
  else
    return true
  end
end

def move(board, index, character)
  if valid_move?(board, index)
    board[index] = character
    return true
  end
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|

    position = [
      board[win_combination[0]],
      board[win_combination[1]],
      board[win_combination[2]]
    ]

    if position.select{|i| i == "X"}.length == 3 || position.select{|i| i == "O"}.length == 3
      return win_combination
    end

  end

  return false
end

def full?(board)
  board.select{|i| i == "X"}.length + board.select{|i| i == "O"}.length == 9
end

def draw?(board)
  !(won?(board)) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def turn_count(board)
  counter = 0
  board.each do |pos|
    if pos == "X" || pos == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
