
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(arr)
  puts " #{arr[0]} | #{arr[1]} | #{arr[2]} "
  puts "-----------"
  puts " #{arr[3]} | #{arr[4]} | #{arr[5]} "
  puts "-----------"
  puts " #{arr[6]} | #{arr[7]} | #{arr[8]} "
end

def input_to_index(number)
  number.to_i - 1
end

def move(board_array, index, player)
  board_array[index] = player;
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  if position_taken?(board, index) || !index.between?(0, 8)
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else turn(board)
  end
  display_board(board)
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position != " "
      counter += 1
    end
  end
  counter
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if combination.all? {|a| board[a] == "O"}
      winner = "O"
      return combination
    elsif combination.all? {|a| board[a] == "X"}
      winner = "X"
      return combination
    end
  end
  return false
end

def full?(board)
  board.each do |position|
    if position == " "
      return false
    end
    true
  end
end

def draw?(board)
  if full?(board) &&  !won?(board)
    true
  else false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    true
  else false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]] #Grabs the value from the first element in the winning array...
  else return nil
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
