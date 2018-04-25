WIN_COMBINATIONS = [[0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(string)
  index = string.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index >= 0 && index < 9
    if board[index] == " "
      return true
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if turn_count(board) % 2 == 0
    char = "X"
  else
    char = "O"
  end
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |element|
    if element != " "
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]] && position_taken?(board, win_combo[1])
  end
end

def full?(board)
  board.all? { |item| item != " "}
end

def draw?(board)
  if !full?(board)
    return false
  elsif !won?(board) && full?(board)
    return true
  elsif !won?(board) && !full?(board)
    return false
  elsif won?(board)
    return false
  end
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  index = []
  index = won?(board)
  if index == nil
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
