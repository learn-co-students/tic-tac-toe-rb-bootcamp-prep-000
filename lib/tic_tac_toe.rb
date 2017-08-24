def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2], [3, 4, 5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

def won?(board)
  winning_array = []
  x_count = 0
  o_count = 0
  WIN_COMBINATIONS.each do |win_possibility|
    win_possibility.each do |check_item|
      if board[check_item] == "X"
        x_count +=1
      elsif board[check_item] == "O"
          o_count +=1
      end
    end
    if x_count == 3
      return win_possibility
    elsif o_count == 3
      return win_possibility
    else
      x_count = 0
      o_count = 0
    end
  end
  return false
end

def full?(board)
  board.none?{|i| i == " "}
end

def draw?(board)
  full?(board) == true && won?(board) == false
end


def winner(board)
  x_win = 0
  o_win = 0
  check_array = won?(board)
  if check_array == false
    return nil
  end
  check_array.each do |i|
    if board[i] == "X"
      x_win += 1
    end
  end
  if x_win == 3
    return "X"
  end
  check_array.each do |i|
    if board[i] == "O"
      o_win += 1
    end
  end
  if o_win == 3
    return "O"
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
end
end


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

def over?(board)
  won?(board) != false || draw?(board) == true || full?(board) == true
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
