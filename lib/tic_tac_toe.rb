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

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

def display_board (board = ["   ","   ","   ","   ","   ","   ","   ","   ","   "])
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "

end

def input_to_index(input)
  index = input.to_i - 1
end

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index)
    false
  elsif index > -1 && index < 9
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) 
    move(board, index, "#{current_player(board)}")
    display_board(board)
  elsif turn(board)
  end 
end  

def turn_count(board)
  turn_counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      turn_counter += 1
    end     
  end
  turn_counter
end  

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
      
end  

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] == board[combination[1]] &&
    board[combination[1]] == board[combination[2]] &&
    position_taken?(board, combination[0])
  end
end

def full?(board)
  board.all? {|space| space == "X" || space == "O"}
end

def draw?(board)
  if !(won?(board)) && full?(board)
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

def winner(board)
  if won?(board)
    winning_board = won?(board)
    return board[winning_board.first]
  else
    nil
  end
end
