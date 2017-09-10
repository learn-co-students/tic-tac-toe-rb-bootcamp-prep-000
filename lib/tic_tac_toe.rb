
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[2,5,8],[0,4,8],[2,4,6],[1,4,7]]
board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts (print "-----------")
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts (print "-----------")
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def won? (board)

  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = board[win_combination[0]]
    win_index_2 = board[win_combination[1]]
    win_index_3 = board[win_combination[2]]

    if win_index_1 == win_index_2 && win_index_2 == win_index_3 && win_index_1 != " "
      return win_combination
    end
  end
end

def full? (board)
  board.all?{|number| number == "X" || number == "O"}
end

def draw? (board)
  full?(board) && !won?(board) ? true : false
end

def over?(board)
  draw?(board)|| won?(board)? true : false
end

def winner(board)
  the_winner = won?(board)
  if the_winner
    return board[the_winner[0]]
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  input = input_to_index(user_input)
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  else
    return false
  end
end


def valid_move?(board, index)
  if !(position_taken?(board, index)) && index.between?(0,8)
    return true
  else
    return false
  end
end

def input_to_index(input)
  input = input.to_i
  return input - 1
end

def move (board, index, value)
  board[index] = value
end

def turn_count(board)
  count_array = board.select{|number| number == "X" || number == "O"}
  return count_array.length
end

def current_player(board)
  current_player = turn_count(board)% 2 == 0? "X" : "O"
  return current_player
end

def play(board)
  while over?(board) == false
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  puts "Cat's Game!"
end
