WIN_COMBINATIONS = [
  [0,1,2], #Top row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,4,8], #Diagonal 1
  [2,4,6], #Diagonal 2
  [0,3,6], #Left column
  [1,4,7], #Middle column
  [2,5,8], #Right column
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

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
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
  board.each do |element|
    if element == "X" || element == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_x = combo.all?{|index| board[index] == "X"}
    win_o = combo.all?{|index| board[index] == "O"}
    if win_x == true || win_o == true
      return combo
    end
  end
  false
end

def full?(board)
  full = !board.include?(" ")
  full
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board) != false
    board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn_count(board)
    turn(board)
  end
  if draw?(board) == true
    puts "Cats Game!"
  elsif won?(board) != false
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
end
