WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
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

def move(board_array, index, player_character)
  board_array[index] = player_character
end

def position_taken?(board, index)
  if (board[index] == " " || board[index] == "" || board[index] == nil )
    false
  elsif (board[index] == "X" || board[index] == "O")
    true
  end
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp

  index = input_to_index(user_input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end

  display_board(board)
end

def turn_count(board)
  turns_played = 0
  board.each_with_index do |space, index|
    if position_taken?(board, index)
      turns_played += 1
    end
  end

  return turns_played
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    else
      false
    end
  end
end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  if won?(board)
    false
  elsif !full?(board)
    false
  elsif full?(board)
    true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end

  false
end

def winner(board)
  if !won?(board)
    return nil
  elsif board[won?(board)[0]] == "X"
    return "X"
  elsif board[won?(board)[0]] == "O"
    return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
