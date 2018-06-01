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

def move(board, i, token)
  board[i] = token 
end

def position_taken?(board, i)
  !(board[i].nil? || board[i] == " " || board[i] == "")
end

def valid_move?(board, i)
  (i.between?(0, 8) && !position_taken?(board, i))
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else 
    turn(board)
  end
end 

def turn_count(board)
  board.select{ |cell| cell == "X" || cell == "O" }.length
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8],
  [0,3,6], [1,4,7], [2,5,8],
  [0,4,8], [2,4,6]
  ]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
 #   index_1 = combo[0]
 #   index_2 = combo[1]
 #   index_3 = combo[2]
 #   position_1 = board[index_1]
 #   position_2 = board[index_2]
 #   position_3 = board[index_3]
    if position_taken?(board, combo[0]) && board[combo[1]] == board[combo[0]] && board[combo[2]] == board[combo[0]]
      return combo
    end
  end
  return false
end

def full?(board)
  board.all?{ |cell| cell == "X" || cell == "O" }
 # return status.length == 9
end

def draw?(board)
  return full?(board) && !won?(board)
end
 
def over?(board)
  return draw?(board) || won?(board)
end

def winner(board)
  if win_combo = won?(board)
    board[win_combo.first]
  end
end


def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    puts "Something went wrong."
  end
end


