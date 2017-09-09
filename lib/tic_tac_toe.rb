require 'pry'
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

def play(board)
  while(!over?(board))
      turn(board)

    end
  if(winner(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

def display_board(board)
  line = "-----------"
  puts(" #{board[0]} | #{board[1]} | #{board[2]} ")
  puts("#{line}")
  puts(" #{board[3]} | #{board[4]} | #{board[5]} ")
  puts("#{line}")
  puts(" #{board[6]} | #{board[7]} | #{board[8]} ")
end

def input_to_index(input)
  input.to_i - 1;
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if (!position_taken?(board, index))
    if index.between?(0, 8)
      true
    else
      false
    end
  elsif (position_taken?(board, index))
      return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if(valid_move?(board, index))
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  move = 0
  board.each do |player|
    if(player == "X" || player == "O")
      move += 1
    end
  end
  move
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    #binding.pry
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return false
end

def full?(board)
  return board.none?{|i| i == " "}
end

def draw?(board)
  if won?(board) == false
    if full?(board)
      return true
    end
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)

  if(over?(board))
    if(won?(board))
      winner = board[won?(board)[0]]
    end
  else
    nil
  end
end
