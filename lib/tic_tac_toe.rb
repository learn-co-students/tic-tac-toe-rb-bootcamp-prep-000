require "pry"

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

def display_board(board)
  puts " #{board[0]} "+"|"+" #{board[1]} "+"|"+" #{board[2]} "
  puts "-----------"
  puts " #{board[3]} "+"|"+" #{board[4]} "+"|"+" #{board[5]} "
  puts "-----------"
  puts " #{board[6]} "+"|"+" #{board[7]} "+"|"+" #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "It is #{current_player(board)}'s turn"
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board)
  # binding.pry
  if turn_count(board).odd?
    "O"
  else
    "X"
  end
end

def won?(board)
  win_index_1 = ""
  win_index_2 = ""
  win_index_3 = ""
  pos_1 = ""
  pos_2 = ""
  pos_3 = ""
  win_combo_f = []
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]
    pos_1 = board[win_index_1]
    pos_2 = board[win_index_2]
    pos_3 = board[win_index_3]
    # binding.pry
    if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
      return win_combo_f = win_combo
    elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
      return win_combo_f = win_combo
    else
      win_combo_f = false
    end
  end
  win_combo_f
end

def full?(board)
  if board.include?(" ") || board.include?("") || board.include?(nil)
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
  if draw?(board) == true
    return true
  elsif WIN_COMBINATIONS.include? (won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) == false
    return nil
  else
    temp_a = won?(board)
    if board[temp_a[0]] == "X" &&   board[temp_a[1]] == "X" && board[temp_a[2]] == "X"
      return "X"
    elsif board[temp_a[0]] == "O" && board[temp_a[1]] == "O" && board[temp_a[2]] == "O"
      return "O"
    end
  end
end

def play(board)
  while over?(board) == false && won?(board) == false
    turn(board)
  end
  if draw?(board) == true
    puts "Cat's Game!"
  else
    if winner(board) == "X"
      puts "Congratulations X!"
    elsif winner(board) == "O"
      puts "Congratulations O!"
    end
  end
end
