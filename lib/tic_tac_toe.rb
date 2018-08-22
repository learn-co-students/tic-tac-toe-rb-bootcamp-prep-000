WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-"*11
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-"*11
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input = input.to_i - 1
end

def move(board_array, index, character)
  board_array[index] = character
end

def position_taken?(board, index)
  val = true
  if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
    val = false
  end
  val
end

def valid_move?(board, index)
  index.between?(0, 8) == true && position_taken?(board,index) == false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    #if turn_count(board).even?
    #  move(board, index)
    #else
    #  move(board, index, current_player(board))
    #end
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = []
  board.each do |item|
    if item != " " && item != "" && item != nil
      turns.push(item)
    end
  end
  turns.size
end

def current_player(board)
  count = turn_count(board) + 1
  current = count.even? == true ? "O" : "X"
end

def won?(board)
  answer = false
  WIN_COMBINATIONS.each do |row|
    win_index_1 = row[0]
    win_index_2 = row[1]
    win_index_3 = row[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      answer = row
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      answer = row
    end
  end
  answer
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
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
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
