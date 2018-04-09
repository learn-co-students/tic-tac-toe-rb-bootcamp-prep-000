WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
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

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def move(board, index, player)
  board[index] = player
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn_count(board)
  occupied_spaces = 0
  
  board.each do |space|
    if !(space.nil? || space == " ")
      occupied_spaces += 1
    end
  end
  
  occupied_spaces
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9: "
  input = gets.strip
  index = input_to_index(input)
  
  if (valid_move?(board, index))
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  
  false
end

def full?(board)
  board.none? { |cell| cell.nil? || cell == " " }
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  else
    false
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def play(board)
  until over?(board) do
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end


