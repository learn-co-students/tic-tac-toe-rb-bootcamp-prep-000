WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                    [0, 3, 6], [1, 4, 7], [2, 5, 8],
                    [2, 4, 6], [0, 4, 8]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input = -1)
  position = input.to_i - 1
end

def move(board, index, xo)
  board[index] = xo
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if (index >= 0 && index < 9) && position_taken?(board, index) == false
    return true
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
    puts "Invalid move"
    turn(board)
  end
end

def turn_count(board)
  turn = 0
  board.each do |piece|
    if piece == "X" || piece == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    if board[win_combo[0]] == board[win_combo[1]] &&
       board[win_combo[1]] == board[win_combo[2]] &&
       position_taken?(board, win_combo[0])
      return win_combo
    end
  end
  return false
end

def full?(board)
  if board.detect{|char| char == " " || char == ""}
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end

def over?(board)
  if draw?(board) == true || won?(board) != false
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    return board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    if !won?(board)
      turn(board)
    end
  end

  if won?(board) != false
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  end

  if draw?(board)
    puts "Cat's Game!"
  end
end
