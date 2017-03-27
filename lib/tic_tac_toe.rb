def play(board)
  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  elsif !!won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
end

WIN_COMBINATIONS = [
  #rows
  [0,1,2],
  [3,4,5],
  [6,7,8],
  #columns
  [0,3,6],
  [1,4,7],
  [2,5,8],
  #diagonals
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  line = ""
  11.times {line = line + "-"}
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts line
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts line
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input = input.to_i
  index = input - 1
  return index
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index < 0 || index > 8
    return false
  elsif position_taken?(board, index)
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = gets.strip
  index = input_to_index(index)
  if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
  else
     turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |place|
      if place != " "
        counter += 1
      end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)

  players = ["X", "O"]
  winner = false

  players.each do |player|
    WIN_COMBINATIONS.each do |combo|
      #simplify with all? or detect?
      if board[combo[0]] == player &&  board[combo[1]] == player && board[combo[2]] == player
        winner = combo
      end
    end
  end
  return winner
end

def full?(board)
  board.none? do |place|
    place == " "
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if !(won?(board) || draw?(board))
    return false
  else
    return true
  end
end

def winner(board)
  winning_combo = won?(board)
  if over?(board)
    return board[winning_combo[0]]
  end
end
