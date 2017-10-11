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

def move(board, input, char)
  board[input] = char
end

def valid_move?(board, index)
  (index.between?(0,8) && !position_taken?(board, index)) ?
  true : false
end

def position_taken?(board, position)
  (board[position] == "X" || board[position] == "O") ?
  true : false
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
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn_count(board) % 2 == 0 ?
    "X" : "O"
end

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

def won?(board)
    WIN_COMBINATIONS.each do |win|
     if (board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X") ||
        (board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O")
       return win
     end
   end
   return false
end

def full?(board)
   board.all? do |position|
     position == "X" || position == "O" ?
     true : false
   end
end

def draw?(board)
   !(won?(board) || !full?(board))
end

def over?(board)
   (won?(board) || draw?(board))
end

def winner(board)
   if won?(board)
     return board[won?(board)[0]]
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
  # turns = 0
  # while turns < 9
    # turn(board)
  #   turns += 1
  # end
end
