WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # bottom row
  [0,3,6],  # first column
  [1,4,7], # second column
  [2,5,8],  # third column
  [0,4,8], # diagonal left to right
  [2,4,6]  # diagonal right to left
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end


def position_taken?(board, index)
  if board[index] == " "
    return false
  elsif board[index] == ""
    return false
  elsif board[index] == nil
    return false
  elsif (board[index] == "X") || (board[index] == "O")
    return true
  end
end

def valid_move?(board, index)
  taken = position_taken?(board, index)
  if ((index >= 0) && (index <= 8)) && (taken == false)
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  valid = valid_move?(board, index)
  if valid == true
    move(board, index, value)
    display_board(board)
  elsif
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |place|
    if place == "X"
      count += 1
    elsif place == "O"
      count+=1
    end
  end
  return count
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do | combination |
      win_index_1 = combination[0]
      win_index_2 = combination[1]
      win_index_3 = combination[2]
      puts "#{win_index_1}, #{win_index_2}, #{win_index_3}"
      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
      puts "#{position_1}, #{position_2}, #{position_3}"
      if (position_1 =="X") && (position_2 == "X") && (position_3 == "X")
        return [win_index_1, win_index_2, win_index_3]
      elsif (position_1 =="O") && (position_2 == "O") && (position_3 == "O")
        return [win_index_1, win_index_2, win_index_3]
      end
  end
  return false
end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
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
  if (won?(board) != false) || (draw?(board) == true)
    return true
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    winning = won?(board)
    return board[winning[0]]
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end
  if won?(board) != false
    winner = winner(board)
    puts winner
    puts "Congratulations #{winner}!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
