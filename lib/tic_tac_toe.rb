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
def move(board, index, letter)
  board[index] = letter
end
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end
def turn(board)
  puts "Please enter 1-9:"
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
  counter = 0
  board.each do |count|
    if count == "X" || count == "O"
      counter += 1
    end
  end
  return counter
end
def current_player(board)
  z = turn_count(board)
  if z % 2 == 0
    return "X"
  else
    return "O"
  end
end
def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
      number_f = win_combo[0]
      number_s = win_combo[1]
      number_t = win_combo[2]
      if board[number_f] == "X" && board[number_s] == "X" && board[number_t] == "X"
        return [number_f, number_s, number_t]
      elsif board[number_f] == "O" && board[number_s] == "O" && board[number_t] == "O"
        return [number_f, number_s, number_t]
      end
    end
  return false
end
def full?(board)
  board.each do |square|
    if square == " " || square == "" || square == nil
      return false
    end
  end
  return true
end
def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
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
  if won?(board) == false
    nil
  else
    win_array = won?(board)
    find_letter = win_array[0]
    return board[find_letter]
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
