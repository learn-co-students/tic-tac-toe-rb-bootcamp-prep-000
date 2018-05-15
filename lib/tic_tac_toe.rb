def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

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

def input_to_index(user_input)
  user_input.to_i - 1
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def move(board, index, player_character)
  board[index] = player_character
end

def valid_move?(board, location)
  !position_taken?(board, location) && location.between?(0, 8)
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9"
  user_input = gets.strip
  location = input_to_index(user_input)
  if valid_move?(board, location)
    player_character = current_player(board)
    move(board, location, player_character)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_number = 0
  board.each do |character|
    if character == "X" || character == "O"
      turn_number += 1
    end
  end
  turn_number
end

def current_player(board)
  character = ""
  if turn_count(board).even?
    character = "X"
  elsif turn_count(board).odd?
    character = "O"
  end
end

def won?(board)
  winner = ""
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      winner = false
    end
  end
  winner
end

def full?(board)
  board.all? do |character|
    character == "X" || character == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winning_player = nil
  if won?(board)
    winning_positions = won?(board)
    winning_positions.all? do |index|
      if board[index] == "X"
        winning_player = "X"
      elsif board[index] == "O"
        winning_player = "O"
      end
    end
  end
  winning_player
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    display_board(board)
    puts "Congratulations #{winner(board)}!"
    play_again
  elsif draw?(board)
    display_board(board)
    puts "Cat's Game!"
    play_again
  end
end

def play_again
  puts "Would you like to play again? (y/n)"
  answer = gets.strip
  if answer == "y"
    board = board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    play(board)
  elsif answer == "n"
    puts "Goodbye! Thank you for playing!"
    exit
  else play_again
  end
end
