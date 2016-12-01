WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]

def display_board(array)
  print " #{array[0]} | #{array[1]} | #{array[2]} \n"
  11.times{ print "-" }
  puts
  print print " #{array[3]} | #{array[4]} | #{array[5]} \n"
  11.times{ print "-" }
  puts
  print print " #{array[6]} | #{array[7]} | #{array[8]} \n"
end

def input_to_index(input)
  input.to_i - 1
end

def move (board_array, index_tofill, character)
  board_array[index_tofill] = character
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == true || index.between?(0,8) == false
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  count = turn_count(board)
  count % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_arr|
     test = win_arr.all? do |ele|
      board[ele] == "X" || win_arr.all? do |ele|
       board[ele] == "O"
     end
    end
    if test == true
    return win_arr
    end
  end
  false
end

def full?(board)
  board.all? do |space|
    space == "X" || space == "O"
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  elsif won?(board) == false && full?(board) == false
    return false
  else
    return false
  end
end

def over?(board)
  full?(board) == true || draw?(board) == true || won?(board) != false
end

def winner(board)
  won?(board) != false ? board[won?(board)[1]].to_s : nil
end

def play(board)
  until over?(board) == true
    turn(board)
  end
    if won?(board) != false
      win_person = winner(board)
      puts "Congratulations #{win_person}!"
    else
      puts "Cats Game!"
  end
end
