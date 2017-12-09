
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
 puts " #{board[0]} | #{board[1]} | #{board[2]} "
 puts "-----------"
 puts " #{board[3]} | #{board[4]} | #{board[5]} "
 puts "-----------"
 puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  converted_input = "#{user_input}".to_i - 1
end

def move(board, converted_input, character)
  board[converted_input] = character
end

def position_taken?(board, index)
  position = nil
    if (board[index] ==  " " || board[index] == "" || board[index] == nil)
    position = false
    else
    position = true
    end
    position

end

def valid_move?(board, index)
move = nil
  if index.between?(0,8) && !position_taken?(board, index)
    move = true
  else
    move = false
  end
  move
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  converted_input = input_to_index(user_input)
  if valid_move?(board, converted_input) == true
  move(board, converted_input, current_player(board))
  display_board(board)
  else
    turn(board)
  end
end

def turn_count (board)
  counter = 0
  board.each do |turn|
  if turn == "X" || turn == "O"
     counter += 1
  end
end
counter
end

def current_player(board)

  if turn_count(board) == 0
    return "X"
  elsif turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

  def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? do |combo|
    combo == "X" || combo == "O"
  end
end

def draw?(board)
  full?(board) and !won?(board)
end

def over?(board)
  draw?(board) or won?(board)
end

def winner(board)
  if winner = won?(board)
    board[winner[0]]
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
