WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5], 
  [6, 7, 8], 
  [0, 3, 6], 
  [1, 4, 7], 
  [2, 5, 8], 
  [0, 4, 8], 
  [2, 4, 6] 
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

def move(board, index, position)
  board[index] = position
end

def position_taken?(board, index)
  if board[index] == "X" || "O"
    true
  else
  false
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    if turn_count(board) % 2 == 0
      player_mark = "X"
    else
      player_mark = "O"
    end
    move(board, index, player_mark)
    display_board(board)
  else
    turn(board)
  end
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

def turn_count(board)
  occupied = 0
  board.each do |b|
    if b == "X" || b == "O"
      occupied += 1
    end
  end
  return occupied
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else 
    return "O"
  return player
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index1 = win_combo[0]
    win_index2 = win_combo[1]
    win_index3 = win_combo[2]

    if (board[win_index1] == "X" && board[win_index2] == "X" && board[win_index3] == "X")
      return win_combo
    elsif (board[win_index1] == "O" && board[win_index2] == "O" && board[win_index3] == "O")
      return win_combo
    end
  end
  if board.none? {|position| position == " " || position == "" || position == nil}
    return false
  elsif board = Array.new(9,"") || board = Array.new(9," ")
    return false
  else
    return false
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false
    return true
  elsif full?(board) == true
    return true
  end
end

def winner(board)
  if won?(board)
    win_combo = won?(board)
    sample_index = win_combo[0]
    if board[sample_index] == "X"
      return "X"
    elsif board[sample_index] == "O"
      return "O"
    end
  end
  return nil
end

def play(board)
  while over?(board) != true && draw?(board) != true
  end
  if over?(board) == true
    if won?(board) != false 
      puts "Congratulations #{winner(board)}!" 
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
end
