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

def move(board, fill_i, character)
  board[fill_i] = character
end

def position_taken?(board, pos)
  board[pos] != " "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter position 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  filledArr = board.select {|pos| pos != " "}
  filledArr.length
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each {|combo|
    w_pos_1 = combo[0]
    w_pos_2 = combo[1]
    w_pos_3 = combo[2]

    if (board[w_pos_1] == "X" && board[w_pos_2] == "X" && board[w_pos_3] == "X") || (board[w_pos_1] == "O" && board[w_pos_2] == "O" && board[w_pos_3] == "O")
      return combo
    end
  }
  false
end

def full?(board)
  freeArr = board.select {|pos|
    pos == " "
  }
  freeArr.length == 0
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  WIN_COMBINATIONS.each {|combo|
    w_pos_1 = combo[0]
    w_pos_2 = combo[1]
    w_pos_3 = combo[2]

    if (board[w_pos_1] == "X" && board[w_pos_2] == "X" && board[w_pos_3] == "X")
      return "X"
    elsif (board[w_pos_1] == "O" && board[w_pos_2] == "O" && board[w_pos_3] == "O")
      return "O"
    end
  }
  nil
end

def play(board)
  until over?(board)
    turn(board) #take turns
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
