

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
  user_input = user_input.to_i
  index = user_input - 1
  return index
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  return index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  #turn asks the user for input by printing: "Please enter 1-9:"
  puts "Please enter 1-9:"
  #turn gets the user input
  user_input = gets.strip
  #turn calls the input_to_index method
  index = input_to_index(user_input)
  #turn validates the input correctly
  if valid_move?(board, index)
    #turn makes valid moves
    move(board, index, current_player(board))
  else
    #turn asks for input again after a failed validation
    turn(board)
  end
  #turn displays a correct board after a valid turn
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == 'X' || space == 'O'
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    current_player = 'X'
  else
    current_player = 'O'
  end
  return current_player
end

def check_win_combination?(board, player, win_combo)
  win_combo.all? do |position|
    board[position] == player
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if check_win_combination?(board, 'X', win_combo)
      return win_combo
    elsif check_win_combination?(board, 'O', win_combo)
      return win_combo
    end
  end
    return false
end

def full?(board)
  if board.include?(' ') || board.include?('')
    return false
  else
    return true
  end
end

def draw?(board)
 if !won?(board) && full?(board)
   return true
 end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board) # accepts a board and returns a token
  if !won?(board)
    return nil
  else WIN_COMBINATIONS.each do |win_combo|
    if check_win_combination?(board, 'X', win_combo)
      return 'X'
    elsif check_win_combination?(board, 'O', win_combo)
      return 'O'
    end
  end
end
end

def play(board) # good method
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations " + winner + "!"
  else
    puts "Cats Game!"
  end
end
