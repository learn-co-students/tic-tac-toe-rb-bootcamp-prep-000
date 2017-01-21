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

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player_token)
  board[index] = player_token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")

  #![nil, " "].include?(board[index])
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  turn_counter = 0
  board.each do |token|
      if "#{token}" == "X" || "#{token}" == "O"
      turn_counter += 1
    end
  end
  turn_counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect {|winning_array|
    board[winning_array[0]] == board[winning_array[1]] &&
    board[winning_array[1]] == board[winning_array[2]] &&
    position_taken?(board, winning_array[0])
  }
end

def full?(board)
  board.all? {|i| i == "X" || i == "O"}
end

def draw?(board)
   full = full?(board)
   won = won?(board)
   full && !won

  # full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  else
    nil
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  # keep asking for a move until the user enters a valid move
  if !valid_move?(board, index)
    turn(board)
  else
    move(board, index, current_player(board))
    display_board(board)
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end


  # turn(board)
  # over?(board)
  #   if won?(board)
  #     puts "Congratulations #{winner(board)}!"
  #   else draw?(board)
  #     puts "Cats Game!"
  #   end
  # turn(board)
end
