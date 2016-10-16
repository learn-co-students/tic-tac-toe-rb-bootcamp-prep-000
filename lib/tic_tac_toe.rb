WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #left column
  [1, 4, 7], #middle column
  [2, 5, 8], #right column
  [0, 4, 8], #top left to bottom right diagonal
  [6, 4, 2] #bottom left to top right diagonal
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

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  current_player = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  occupied_cells = board.select {|cell| cell == "X" || cell == "O"}
  occupied_cells.length
end

def current_player(board)
  turn_count(board).even? ? current_player = "X" : current_player = "O"
end

def won?(board)
  if WIN_COMBINATIONS.any? do |win_combination|
      win_combination.all? {|index| board[index] == "X"} ||
      win_combination.all? {|index| board[index] =="O"}
    end
    WIN_COMBINATIONS.each do |win_combination|
      if win_combination.all? {|index| board[index] == "X"} ||
        win_combination.all? {|index| board[index] =="O"}
        return win_combination
      end
    end
  else false
  end
end

def full?(board)
  board.all? {|i| i == "X" || i == "O" }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board)
    winner = won?(board).first
    board[winner]
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
