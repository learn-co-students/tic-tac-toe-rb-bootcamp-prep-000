WIN_COMBINATIONS = [
                    [0, 1, 2],
                    [3, 4, 5],
                    [6, 7, 8],
                    [0, 3, 6],
                    [1, 4, 7],
                    [2, 5, 8],
                    [0, 4, 8],
                    [2, 4, 6]]
                    


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

def player_move(board, index, current_player)
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
    player_move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  count = 0
  board.each do |i|
    if i == "X" || i == "O"
      count += 1
    end
  end
  return count
end


def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X" ||
      position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combination
    end
  end
  return false
end 


def full?(board)
  if board.detect{|position| position == "" || position == " "}
    return false
  else
    return true 
  end
end


def draw?(board)
    if full?(board) && !won?(board)
    return true
  else
    return false 
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
  if won?(board)
    return board[won?(board)[0]]
  end
end
  

def play(board)
  turn = 1
  until turn > 9 || over?(board)
    turn(board)
    turn += 1
  end
  if draw?(board)
    puts "Cat's Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end

  