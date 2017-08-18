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

def turn_count (board)
  count = 0
  board.each do |place|
    if (place == "X" || place == "O")
      count +=1
    end
  end
  count
end

def current_player (board)
  (turn_count(board) % 2 == 0)? "X": "O"
end

def won?(board)
  win_comb = []
  WIN_COMBINATIONS.each do |combo|
    if position_taken?(board, combo[0])
      if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
        win_comb = combo
      end
    end
  end
  if win_comb != []
    return win_comb
  else
    return false
  end
end

def full?(board)
  board.all? {|space| space == "X" || space == "O"}
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  winner = won?(board)
  if winner
    return board[winner[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) != nil
      puts "Congratulations #{winner(board)}!"
  elsif over?(board)
      puts "Cats Game!"
  end
end
