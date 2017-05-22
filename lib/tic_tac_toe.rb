WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  row_1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row_2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row_3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  div = "-----------"
  puts row_1
  puts div
  puts row_2
  puts div
  puts row_3
end

def input_to_index(input)
  ("#{input}".to_i) - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index) == false && index.between?(0, 8) == true
    return true
  else
    return false
  end
end

def turn(board)
 puts "Please enter 1-9:"
 input = gets.strip
 index = input_to_index(input)
 if valid_move?(board, index) == true
   move(board, index, value = "#{current_player(board)}")
   display_board(board)
 else
   turn(board)
 end
end

def turn_count(board)
  counter = 0
    board.each do |token|
      if token != " "
        counter += 1
      end
    end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
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

    if (position_1 == "X" && position_2 == "X" && position_3 == "X")  || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    else
    end
  end
  return false
end

def full?(board)
  board.none?{|occ| occ == " " || occ == nil}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cats Game!"
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end
