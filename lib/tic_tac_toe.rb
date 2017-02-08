WIN_COMBINATIONS = [
  [0,1,2], #Top horizontal
  [3,4,5], #Middle horizontal
  [6,7,8], #Bottom horizontal
  [0,3,6], #Left vertical
  [1,4,7], #Middle vertical
  [2,5,8], #Right vertical
  [0,4,8], #Left-to-right diagonal
  [2,4,6] #Right-to-left diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = (user_input.to_i) - 1
end

def move(board, user_input, char)
  board[user_input] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if (position_taken?(board, index) == true) || index.between?(0, 8) == false
    false
  else (index.between?(0, 8) == true) && (position_taken?(board, index) == false)
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip.to_i
  index = input_to_index(user_input)

  if valid_move?(board, index)
    char = current_player(board)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn = "X"
  if turn_count(board).to_i.even? == true
    turn = "X"
  else
    turn = "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect{|win_combo|
    board[win_combo[0]] == board[win_combo[1]] &&
    board[win_combo[1]] == board[win_combo[2]] &&
    position_taken?(board, win_combo[0])
  }
end

def full?(board)
  board.all? {|cell| cell == "X" || cell == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    else winner(board) == "O"
      puts "Congratulations O!"
    end
  else draw?(board)
    puts "Cats Game!"
  end
end
