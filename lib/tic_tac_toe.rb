WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Second column
  [2,5,8], # Third column
  [0,4,8], # First diagonal
  [2,4,6]  # Second diagonal
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

def move(board, index, player_token)
  board[index] = player_token
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
  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_counter = 0
  while_counter = 0
  while while_counter < board.size
    if position_taken?(board, while_counter)
      turn_counter += 1
    end
    while_counter += 1
  end
  return turn_counter
end

def current_player(board)
  player_next = turn_count(board) + 1
  if player_next.odd? || player_next == 0
    return "X"
  elsif player_next.even?
    return "O"
  end
end

def won?(board)
  win = WIN_COMBINATIONS
  counter = 0
  counter_full = 0
  counter_x = 0
  counter_o = 0
  result = 0
  win.each do |combo|
    combo.each do |item|
      if board[item] == "X"
        counter_x += 1
      elsif board[item] == "O"
        counter_o += 1
      end
      if counter_x == 3 || counter_o == 3
        result = win[counter]
      end
    end
    counter_x = 0
    counter_o = 0
    counter += 1
  end
  if result.kind_of?(Array) == true
      return result
  elsif result.kind_of?(Array) == false
    board.each do |vacant|
      if vacant == "" || vacant == " "
        counter_full += 1
      end
    end
    if counter_full == 9
      return false
    end
  end
  if result.kind_of?(Array) == false && counter_full < 9
    counter = 0
    while counter < board.size && position_taken?(board, counter) == true do
        counter+= 1
    end
    if counter == 9
      return false
    end
  end
end

def full?(board)
  if board.include?("") || board.include?(" ")
    false
  else
    true
  end
end

def draw?(board)
  if full?(board) && won?(board) == false
    true
  elsif won?(board)
    false
  else
    false
  end
end

def over?(board)
  if draw?(board)
    true
  elsif won?(board)
    true
  elsif full?(board) == false
    false
  end
end

def winner(board)
  player = won?(board)
  if player.kind_of?(Array) && board[player[0]] == "X" && board[player[1]] == "X" && board[player[2]] == "X"
    "X"
  elsif player.kind_of?(Array) && board[player[0]] == "O" && board[player[1]] == "O" && board[player[2]] == "O"
    "O"
  else
    return nil
  end
end

def play (board)
  while over?(board) == false
    turn(board)
  end
  if draw?(board) == true
    puts "Cats Game!"
  end

  if winner(board)
    puts "Congratulations #{winner(board)}!"
  end

end
