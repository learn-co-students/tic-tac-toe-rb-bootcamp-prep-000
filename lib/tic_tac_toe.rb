2
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
  h_line = "-----------\n"
  row_1 = " #{board[0]} | #{board[1]} | #{board[2]} \n"
  row_2 = " #{board[3]} | #{board[4]} | #{board[5]} \n"
  row_3 = " #{board[6]} | #{board[7]} | #{board[8]} "

  puts row_1 + h_line + row_2 + h_line + row_3
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  board[index] != " "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)

  until (valid_move?(board, index)) do
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
  end

  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |spot|
    count += 1 if spot != " "
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    v_1 = board[combo[0]]
    v_2 = board[combo[1]]
    v_3 = board[combo[2]]

    if v_1 != " " && v_2 != " " && v_3 != " "
      v_1 == v_2 && v_2 == v_3
    end
  end
end

def full?(board)
  turn_count(board) == 9
end

def draw?(board)
  full?(board) if !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  win = won?(board)
  board[win[0]] if win
end

def play(board)
  until(over?(board))
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
