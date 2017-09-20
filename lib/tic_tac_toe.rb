WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  horiz = "-----------"

  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "#{horiz}"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "#{horiz}"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input_int = input.to_i
  index = input_int - 1
end

def move(board, index, char)
  board[index] = char
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ") # NilClass public instance method, nil? -> true
end

def valid_move?(board, index)
  if !position_taken?(board, index)
    if index.between?(0,8)
      true
    else
      false
    end
  else
    false
  end
end

def turn_count(board)
  turns = 0
  board.each do |token|
    if token != "" && token != " " && token != nil
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board)
  turns % 2 == 0 ? player = "X" : player = "O"
  player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  char = current_player(board)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    position_1 = win_combo[0]
    position_2 = win_combo[1]
    position_3 = win_combo[2]
    if position_taken?(board, position_1) && position_taken?(board, position_2) && position_taken?(board, position_3)
      if board[position_1] == board[position_2] && board[position_2] == board[position_3]
        return win_combo
      end
    end
  end
  false
end

# def won?(board)
#   WIN_COMBINATIONS.each do |win_combo|
#     position_1 = win_combo[0]
#     position_2 = win_combo[1]
#     position_3 = win_combo[2]
#     if position_taken?(board, position_1) && position_taken?(board, position_2) && position_taken?(board, position_3)
#       if board[position_1] == board[position_2] && board[position_2] == board[position_3]
#         return win_combo
#       else
#         false
#       end
#     else
#       false
#     end
#   end
#   false
# end

def full?(board)
  board.each_index do |i|
    return false if !position_taken?(board, i)
  end
  true
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board)
    true
  elsif won?(board)
    true
  else
    false
  end
end

def winner(board)
  win_combo = won?(board)
  win_combo ? board[win_combo[0]] : nil
end

def play(board)
  until over?(board)
    turn(board)
  end
  if !!won?(board)
    char = winner(board)
    puts "Congratulations #{char}!"
  else
    puts "Cat's Game!"
  end
end
