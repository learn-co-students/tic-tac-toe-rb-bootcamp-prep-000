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
  puts "It's #{current_player(board)}'s turn."
  puts "Please enter 1-9:"
  input = gets.strip
  if input == "exit"
    over?("exit")
  end
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |pos|
      if pos == "X" || pos == "O"
        counter += 1
      end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Define your play method below

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end

WIN_COMBINATIONS = [
  [0, 1, 2], # Top row
  [3, 4, 5], # Middle row
  [6, 7, 8], # Bottom
  [0, 3, 6], # Left column
  [1, 4, 7], # Middle column
  [2, 5, 8], # Right column
  [0, 4, 8], # Left/Right diagonal
  [2, 4, 6] # Right/Left diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    windex0 = combo[0]
    windex1 = combo[1]
    windex2 = combo[2]

    position_0 = board[windex0]
    position_1 = board[windex1]
    position_2 = board[windex2]

    if position_taken?(board, windex0) && position_0 == position_1 && position_1 == position_2
      return combo
    end
  end
  false
end

def full?(board)
  !(board.include?(" ") || board.include?(""))
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if draw?(board) || won?(board) || board == "exit"
    true
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end
