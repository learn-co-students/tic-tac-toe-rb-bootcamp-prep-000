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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  (board[index] != " " && board[index] != nil)?
  true : false
end

def valid_move?(board, position)
  if position.between?(0,8)
    if !position_taken?(board, position)
      true
    end
  end
end

def turn(board)
  puts "Enter a position 1-9:"
  input = gets.strip

  index = input_to_index(input)

  validation = valid_move?(board, index)

  if validation != true
    puts "Position is taken."
    turn(board)
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  (board.count("X") <= board.count("O"))?
  "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    board_state_at_winning_positions = [board[win_index_1], board[win_index_2], board[win_index_3]]

    if board_state_at_winning_positions == ["X", "X", "X"] || board_state_at_winning_positions == ["O", "O", "O"]
      return win_combination
    end
  end
  false
end

def full?(board)
  if board.all? { |positions| positions == "X" || positions == "O" }
    true
  end
end

def draw?(board)
  win_state = won?(board)
  full_capacity = full?(board)

  if win_state == false
    (full_capacity == true)?
      true : false
  end
end

def over?(board)
  if draw?(board) == true || won?(board) != false
    true
  end
end

def winner(board)
  if won?(board) != false
    winning_positions = won?(board)
    return board[winning_positions[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  winner = winner(board)

  if draw?(board)
    puts "Cat's Game!"
  elsif over?(board) == true
    puts "Congratulations #{winner(board)}!"
  end

end
