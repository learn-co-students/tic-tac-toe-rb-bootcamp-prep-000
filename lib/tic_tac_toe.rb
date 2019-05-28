WIN_COMBINATIONS = [
  [0, 1, 2], # Top Row Win
  [3, 4, 5], # Verti Middle Row Win
  [6, 7, 8], # Bottom Row Win
  [0, 3, 6], # Left Row Win
  [1, 4, 7], # Horiz Middle Row Win
  [2, 5, 8], # Left Row Win
  [0, 4, 8], # Top Left to Bottom Right Diagonal Win
  [6, 4, 2]  # Bottom Left to Top Right Diagonal Win
  ]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input_num = input.to_i
  return input_num - 1
end

def move(board, index, player)
    board[index] = "#{player}"
end

def position_taken?(board, index)
  return !(board[index] == nil || board[index] == " ")
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    return true
  end
false
end

def turn(board)
  puts "Pick a number between 1 and 9:"
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
  count = 0
  board.each do |position|
    if position ==  "X" || position == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X"
      return win_combo
    elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O" 
      return win_combo
    end
  end
false
end

def full?(board)
  return board.all? do |position|
    if position == "X" || position == "O"
     true
    end
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  if !over?(board)
    turn(board)
    play(board)
  elsif over?(board)
    if won?(board)
      winner = winner(board)
      puts "Congratulations #{winner}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
end