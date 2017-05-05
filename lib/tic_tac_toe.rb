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


def move(board, index, token)
  board[index] = token
end


def position_taken?(board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end


def valid_move?(board, index)
  if !position_taken?(board, index) && 0 <= index && index <= 8
    true
  else
    false
  end
end


def turn(board)
  puts "Player #{current_player(board)}, please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else 
    turn(board)
  end
end


def turn_count(board)
  counter = 0
  board.each do |square|
    if square != " "
      counter += 1
    end
  end
  return counter
end


def current_player(board)
  turns = turn_count(board)
  turns % 2 == 0 ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == position_2 && position_2 == position_3 && (position_1 == "X" || position_1 == "O")
      return win_combination
    end
  end
  return false
end


def full?(board)
  board.none?{ |element| element == " "}
end


def draw?(board)
  won = won?(board)
  full = full?(board)
  if won == false && full == true
    return true
  elsif won == false && full == false
    return false
  elsif won != false
    return false
  end
end


def over?(board)
  if won?(board) != false || draw?(board) == true || full?(board) == true
    return true
  end
end


def winner(board)
  if won?(board) == false || draw?(board) == true
    return nil
  end
  winning_line = won?(board)
  index = winning_line[0]
  return board[index]
end


def play(board)
  while over?(board) != true
    turn(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) == true
    puts "Cats Game!"
  end
end