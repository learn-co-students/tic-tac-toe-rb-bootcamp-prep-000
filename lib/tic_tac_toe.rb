WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
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

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if position_taken?(board,combo[0]) && position_taken?(board,combo[1]) && position_taken?(board,combo[2])
      if board[combo[0]] == board[combo[1]]  && board[combo[1]] == board[combo[2]]
        return combo
      end
    end
  end
  false
end

def full?(board)
  !board.include? " "
end

def draw?(board)
  if(!won?(board))
    if(full?(board))
      true
    end
  else
    false
  end
end

def over?(board)
  if(won?(board) || full?(board) || draw?(board))
    true
  else
    false
  end
end

def winner(board)
  win_combo = won?(board)
  if(win_combo == false)
    nil
  else
    board[win_combo[0]]
  end
end

def play(board)
  until(over?(board))
    turn(board)
  end

  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
