WIN_COMBINATIONS = [[0,1,2],
                    [3,4,5],
                    [6,7,8],
                    [0,3,6],
                    [1,4,7],
                    [2,5,8],
                    [0,4,8],
                    [6,4,2]]


def display_board(board)
    puts " #{board[0]} " "|" " #{board[1]} " "|" " #{board[2]} "
    puts "-----------"
    puts " #{board[3]} " "|" " #{board[4]} " "|" " #{board[5]} "
    puts "-----------"
    puts " #{board[6]} " "|" " #{board[7]} " "|" " #{board[8]} "
end

def input_to_index(input)
  user_input = input.to_i
  index = user_input - 1
  return index
end

def move(board, index, character)
  board[index] = character
  return board
end

def position_taken?(board, index)
  if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
    false
  else
    true
  end
end

def valid_move?(board, index)
  if (board[index] == " ") && index.between?(0, 8) && !position_taken?(board, index)
    true
  else
    false
  end
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
  counter = 0
  board.each do |count|
    if (count != " ")
      counter += 1
    end
  end
  counter
end

def current_player(board)
  counter = 0
  board.each do |count|
    if (count == " ")
      counter += 1
    end
      "X"
    end
    if turn_count(board) % 2 == 0
      "X"
    else
      "O"
    end
end

def won?(board)
  WIN_COMBINATIONS.detect do|win_index|
        (board[win_index[0]] == board[win_index[1]]) && (board[win_index[1]] == board[win_index[2]]) && position_taken?(board, win_index[0])
  end
end

def full?(board)
  board.all? do|index|
     (index == "X" || index == "O" )
  end
end

def draw?(board)
   full?(board) && !won?(board)
end

def over?(board)
   won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
  won_board = won?(board)
  won_board[0]
  board[won_board[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    if winner == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  end

  if draw?(board)
    puts "Cat's Game!"
  end
end
