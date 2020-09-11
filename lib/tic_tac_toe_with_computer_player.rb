WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

$round = 1
$player_score = 0
$computer_score = 0

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

def move(board, position, character="X")
  board[position] = character
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  elsif board[index] == "O" || board[index] == "X"
    true
  end
end

def valid_move?(board, index)
  def position_taken?(board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil
      false
    elsif board[index] == "O" || board[index] == "X"
      true
    end
  end

  position = position_taken?(board, index)

  if position == true
    false
  elsif index.between?(0,8)
    true
  else
    false
  end
end

def move(board, index, token)
  board[index] = token
end

def computer_turn(board)
  index = rand(8)

  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    computer_turn(board)
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    if turn_count(board) == 9 || won?(board)
      display_board(board)
    else
      computer_turn(board)
      display_board(board)
    end
  else
    puts "Invalid move"
    turn(board)
  end
end

def turn_count(board)
  turn_number = 0
  board.each do |counter|
    if counter == "X" || counter == "O"
      turn_number += 1
    else
    end
  end
  turn_number
end

def current_player(board)
  if turn_count(board).even?
    "X"
  elsif turn_count(board).odd?
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == position_2 && position_2 == position_3 && position_1 == position_3
      if position_taken?(board, win_index_1)
        return win_combination
      end
    end
  end
  return false
end

def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  elsif won?(board)
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

def score_keep
  puts " "
  puts "----- Round #{$round += 1}! -----"
  puts "Player: #{$player_score} Computer: #{$computer_score}"
  puts " "
end

def play_again?(board)
  puts "Would you like to play again? Y/N"
  input = gets.strip.downcase

  if input == "yes" || input == "y"
    board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    score_keep
    display_board(board)
    play(board)
  elsif input == "no" || input == "n"
    exit
  else
    play_again?(board)
  end
end

  if won?(board)
    if winner(board) == "X"
      puts "Congratulations! You beat the computer!"
      $player_score += 1
      play_again?(board)
    else
      puts "The computer beat you :("
      $computer_score += 1
      play_again?(board)
  end
  else draw?(board)
    puts "Cat's Game!"
    play_again?(board)
  end
end
