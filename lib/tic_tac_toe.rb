

WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
]

def display_board(board = Array.new(9, " "))
   board_game_division = "-----------"
   puts " #{board[0]} | #{board[1]} | #{board[2]} ",
        board_game_division,
        " #{board[3]} | #{board[4]} | #{board[5]} ",
        board_game_division,
        " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(int)
   num = int.to_i
   num - 1
 end

def move(array, index, value)
   array[index] = value
end

def valid_move?(board, index)
  if position_taken?(board, index) == index.between?(0, 8)
    return false
  else
    return true
  end
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  value = current_player(board)
  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  else turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |plays|
    if plays == "X" || plays == "O"
      counter += 1
    end
    end
    return counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |winning_array|
  if (winning_array.all?{|index| board[index] == "X"}) || (winning_array.all?{|index| board[index] == "O"})
    return winning_array
  end
end
return false
end

def full?(board)
if board.all?{|includes| includes == "X" || includes == "O"}
  return true
else
  return false
end
end

def draw?(board)
if won?(board) != false
  return false
elsif full?(board) == true
  return true
else
  return false
end
end

def over?(board)
  if (draw?(board) == true) || (full?(board) == true) || (won?(board) != false)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != false
    return board[won?(board)[0]]
  else
    return nil
end
end

def play(board)
until over?(board)
  turn(board)
end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cat's Game!"
end
end
