WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]


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

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  current_player = current_player(board)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |square|
    if square === "O" || square === "X"
      count += 1
    end
  end
    return count
end

def current_player(board)
  player = ""
  turn_count(board) % 2 === 0 ? player = "X" : player = "O"
end

def won?(board)
  status = false
    if board.all? {|square| square === " "}
      return status
    end
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
      if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
         (position_1 == "O" && position_2 == "O" && position_3 == "O")
         status = true
        return win_combination # return the win_combination indexes that won.
      else
        status = false
      end
    end
    return status
end

def full?(board)
	board.all? {|square| square == "X" || square == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if draw?(board) == true || won?(board) != false
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    if board.count("X") > board.count("O")
      winner = "X"
    else
      winner = "O"
    end
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif  winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end
