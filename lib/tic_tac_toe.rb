WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]] && (board[combo[0]] == "X" || board[combo[0]] == "O")
      return combo
    end
  end
  return FALSE
end

def full?(board)
  board.detect{|cell| cell == " "} ? FALSE : TRUE
end

def draw?(board)
  !won?(board)&&full?(board)
end

def over?(board)
  won?(board)||draw?(board)
end

def winner(board)
  if over?(board) && !draw?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def current_player(board)
  return (turn_count(board) % 2 == 0) ? "X" : "O"
end

def turn_count(board)
  count = 0
  board.each do |cell|
    if cell=="X" || cell=="O"
      count +=1
    end
  end
  return count
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

def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end